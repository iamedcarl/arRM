require_relative 'db_connection'
require_relative 'associatable'
require_relative 'searchable'
require 'active_support/inflector'

class SQLObject
  def self.table_name=(table_name)
    @table_name = table_name.tableize
  end

  def self.table_name
    @table_name || to_s.tableize
  end

  def self.columns
    if @cols.nil?
      @cols = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{table_name}
        LIMIT
          1
      SQL
    end
    @cols.first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |col|
      set_col = "#{col}="

      define_method(col) do
        attributes[col]
      end

      define_method(set_col) do |value|
        attributes[col] = value
      end
    end
  end

  def self.all
    @all = DBConnection.execute(<<-SQL)
        SELECT
          *
        FROM
          #{table_name}
      SQL
    parse_all(@all)
  end

  def self.parse_all(results)
    results.map { |ivar| new(ivar) }
  end

  def self.find(id)
    @find = DBConnection.execute(<<-SQL, id)
        SELECT
          *
        FROM
          #{table_name}
        WHERE
          id = ?
      SQL
    return nil if @find.count < 1

    new(@find.first)
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      sym_name = attr_name.to_sym
      if self.class.columns.include?(sym_name)
        send("#{sym_name}=", value)
      else
        raise "unknown attribute '#{sym_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |attribute| self.send(attribute) }
  end

  def insert
    col_names = self.class.columns.join(', ')
    count = self.class.columns.count
    question_marks = (['?'] * count).join(', ')
    vars = self.attribute_values

    DBConnection.execute(<<-SQL, *vars)
      INSERT INTO
        #{self.class.table_name}(#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self
      .class
      .columns
      .map { |attr_name| "#{attr_name} = ?" }
      .join(', ')
    vars = self.attribute_values

    DBConnection.execute(<<-SQL, *vars, id.to_s)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL
  end

  def save
    if id.nil?
      self.insert
    else
      self.update
    end
  end

end # End of SQLObject

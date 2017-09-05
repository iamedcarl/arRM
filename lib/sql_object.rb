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

  def initialize(params = {})
    params.each do |attr_name, value|
      sym_name = attr_name.to_sym
      if self.class.columns.include?(sym_name)
        self.send("#{sym_name}=", value)
      else
        raise "unknown attribute '#{sym_name}'"
      end
    end
  end

end

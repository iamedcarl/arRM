require_relative 'db_connection'
require_relative 'associatable'
require_relative 'searchable'
require 'active_support/inflector'

class SQLObject
  def self.table_name=(table_name)
    @table_name = table_name.tableize
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end


end

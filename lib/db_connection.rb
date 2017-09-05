require 'sqlite3'

ROOT_FOLDER = File.join(File.dirname(__FILE__), '..')
SPORTS_SQL_FILE = File.join(ROOT_FOLDER, 'sports.sql')
SPORTS_DB_FILE = File.join(ROOT_FOLDER, 'sports.db')

class DBConnection
  def self.open(db_file_name)
    @db = SQLite3::Database.new(db_file_name)
    @db.results_as_hash = true
    @db.type_translation = true
    @db
  end

  def self.reset
    commands = [
      "rm '#{SPORTS_DB_FILE}'",
      "cat '#{SPORTS_SQL_FILE}' | sqlite3 '#{SPORTS_DB_FILE}'"
    ]

    commands.each { |command| `#{command}` }
    DBConnection.open(SPORTS_DB_FILE)
  end

  def self.instance
    reset if @db.nil?
    @db
  end

  def self.execute(*args)
    print_query(*args)
    instance.execute(*args)
  end

  def self.execute2(*args)
    print_query(*args)
    instance.execute2(*args)
  end

  def self.last_insert_row_id
    instance.last_insert_row_id
  end

end

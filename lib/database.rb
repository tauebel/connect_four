require 'sqlite3'

class Database

  attr_reader :db

  def initialize(db_name, schema = 'schema.sql')
    @db_name = db_name
    create_db(schema)
    @db = SQLite3::Database.open db_name
  end

  def create_db(schema)
    system("sqlite3 #{@db_name} < #{schema}")
  end

end


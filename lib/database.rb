require 'sqlite3'

class Database
  attr_accessor :db, :db_name

  def initialize(db_name, schema = '../db/schema.sql')
    @db_name = db_name
    create_db(schema)
    @db = SQLite3::Database.open db_name
  end

  def self.insert_player(player)
      new("test_db.db").db.execute "INSERT INTO players (name, email, win, loss, draw) VALUES ('#{player.name}', '#{player.email}', 0, 0, 0) ;" if self.not_exists?(player)
  end

  def self.retrieve_player(player)  
    new("test_db.db").db.execute ("SELECT id, name, win, loss, draw FROM players where email = '#{player.email}';"){|row| @row=row}
    if @row[1].to_s == player.name
      return @row
    else
      raise "Cannot Add to Database: Email Already Taken"
    end
  end

  def self.insert_game(player1, player2)
    new("test.db.db").db.execute "INSERT INTO games (player1, player2) VALUES ('#{player1.id}', '#{player2.id}');"
  end

  private
    def create_db(schema)
      system "sqlite3 #{@db_name} < #{schema}"
    end

    def self.not_exists?(player)
      new("test_db.db").db.execute ("SELECT email FROM players where email = '#{player.email}';"){|email| @email = email[0].to_s}
     @email == nil
    end

     
end


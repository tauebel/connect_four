require 'sqlite3'


#require_relative 'player'

class Database
  attr_accessor :db, :db_name

  def initialize(db_name, schema = '../db/schema.sql')
    @db_name = db_name
    create_db(schema)
    @db = SQLite3::Database.open db_name
    # self.db = SQLite3::Database.open db_name
  end

  def create_db(schema)
    system "sqlite3 #{@db_name} < #{schema}"
  end

  def add_player(player)
    @db.execute "INSERT INTO players (name, win, loss, draw) VALUES ('#{player.name}', 0, 0, 0);"
  end

  # def get_player(player)
  #   @db.execute ("SELECT id, name, win, loss, draw FROM players where name = '#{player.name}';"){|row| return row}
  # end

  # def get_player_win_loss(player)
  #   get_player(player)[2..4]
  # end

  # def self.get_player_id(player)
  #   database = Database.new("test_db.db")
  #   database.add_player(player)
  #   database.get_player(player)[0].to_s
  # end

  # # def get_player_id(player)
  # #   # database = Database.new("test_db.db")
  # #   # database.add_player(player)
  # #   @db.get_player(player)[0].to_s
  # # end



  # def self.get_player_win(player)
  #   database = Database.new("test_db.db")
  #   database.add_player(player)
  #   database.get_player(player)[0].to_s
  # end

  # # def get_player_win(player)
  # #   # database = Database.new("test_db.db")
  # #   # database.add_player(player)
  # #   @db.get_player(player)[0].to_s
  # # end

  # def get_player_game_id(player)
  #   @db.execute "SELECT MAX(id) FROM games where player1 = #{player.id}"
  # end  

end


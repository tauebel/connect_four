require 'sqlite3'

class Database
  attr_accessor :db, :db_name

  def initialize(db_name, schema = '../db/schema.sql')
    @db_name = db_name
    create_db(schema)
    @db = SQLite3::Database.open db_name
  end

  def self.insert_player(player)
      new("test_db.db").db.execute "INSERT INTO players (name, email, win, loss, draw, created_at, updated_at) VALUES ('#{player.name}', '#{player.email}', 0, 0, 0, '#{Time.now}', '#{Time.now}') ;" if self.not_exists?(player)
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
    new("test_db.db").db.execute ("INSERT INTO games (player1, player2, created_at, updated_at) VALUES (#{player1.id}, #{player2.id}, '#{Time.now}', '#{Time.now}');")
  end

  def self.retrieve_game
    new("test_db.db").db.execute ("SELECT MAX(id) FROM games;"){|id| return id[0].to_i}
  end

  def self.insert_move(game, player, move)
    new("test_db.db").db.execute ("INSERT INTO game_moves (game_id, player_id, move) VALUES (#{game.id}, #{player.id}, '#{move}');")
  end

  def self.game_winner(game, player)
    new("test_db.db").db.execute ("UPDATE games set winner = #{player.id} WHERE id = #{game.id};")
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


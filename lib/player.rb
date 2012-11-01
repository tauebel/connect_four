require_relative 'database'

class Player

  def self.from_db(db, name)
    attrs   = db.execute ("SELECT id, name, win, loss, draw FROM players where name = '#{name}' limit 1;")
    pl      = Player.new(name)
    pl.id   = attrs[0][0]
    pl.win  = attrs[0][2]
    pl.loss = attrs[0][3]
    pl.draw = attrs[0][4]
    pl
  end

  def self.to_db(db, name)
    attrs   = db.execute "INSERT INTO players (name, win, loss, draw) VALUES ('#{name}', 0, 0, 0);"
  end  

  attr_accessor :name, :id, :win, :loss, :draw

	def initialize(name)
    @name = name
  end

  def make_move
    input = gets.chomp.split(",")
    "#{[input[0].to_i].to_a} #{[input[1].to_i].to_a}"
  end

  def stats
    db.execute("Select wins, loss, draw from Players where id = #{name.id}")
  end
  private

    def get_id
      Database.get_player_id(self)
    end
	
end

db      = SQLite3::Database.open "test_db.db"
ed      = "Edward"
newbie  = Player.to_db(db, ed)

i_am  = Player.from_db(db, ed)
puts i_am.id
puts i_am.name
puts i_am.win
puts i_am.loss
puts i_am.draw




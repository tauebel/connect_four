require_relative 'database'

class Player

  attr_accessor :name, :id

	def initialize(name)
    @name = name
    @id = get_id
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

puts Player.new("Jake").id
#print jake.id

# puts joe.id

require_relative 'game'

class Player

  attr_reader :name

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

end


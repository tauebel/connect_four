require_relative 'player'

class AI
  def initialize(game, board)
    @game = game
    @board = board
    @row = 0
    @column = 0
  end

  def make_move
    @game.make_move(@row, @column)
  end

  def determine_move
    @board.fields.each do |field|
      @board.available_slots.each do |slot|  
        if field.include?(slot)
    @board.available_slots.each do |slot|
      if 
  end
  
end 

bot = AI.new

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
    @filled_possible_fields = []
    @possible_fields = []
    @board.fields.each do |field|
      @board.available_slots.each { |slot|  @possible_fields << slot if field.include?(slot) }
    end
    @possible_fields.each do |field|
      if @board.slot_by_location(field[0], field[1]).color == "Y"
        @possible_fields.delete(field)
      end
    end
    @possible_fields.each do |field|
      @filled_number = 0
      if @board.slot_by_location(field[0], field[1])
        @filled_number += 1
      end
      @filled_possible_fields << @filled_number
    end
  end
  puts @filled_possible_fields
  
end 

bot = AI.new

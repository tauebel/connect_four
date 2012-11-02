require_relative 'game'

class AI
attr_accessor :column, :row

  def initialize(game, board)
    @game = game
    @board = board
    @row = 0
    @column = 0
    @chosen_field = false
  end

  def make_move
    determine_move
    @game.make_move(@column, @row)
    @chosen_field = false
  end

   def best_field
    @possible_fields.each do |field|
      case @board.field_value(field)
      when 15; return @chosen_field = field
      when 3; return @chosen_field = field
      when 10; return @chosen_field = field
      when 2; return @chosen_field = field
      when 5; return @chosen_field = field
      when 1; return @chosen_field = field 
      end
    end
  end

  def determine_move
    best_field
    if @chosen_field != false
      determine_slot 
    else
      random_slot
    end
  end
    
  end

  def determine_slot
    intersection = @chosen_field & @board.available_slots
    coordinates = intersection[0]
    @column = coordinates[0]
    @row = coordinates[1]
  end

  def random_slot
    coordinates = @board.available_slots[[rand(0...@board.available_slots.length)]]
    @column = coordinates[0]
    @row = coordinates[1]
  end



  private

  def get_possible_fields
    @possible_fields = []
    @board.available_slots.each do |slot|
      @board.fields.each do |field|
        @possible_fields << field if field.include?(slot)
      end
    end
    @possible_fields
  end


  
 end 


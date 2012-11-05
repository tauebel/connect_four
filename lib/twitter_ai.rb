
class TwitterAI
  attr_accessor :column, :row

  def initialize(game, board)
    @game = game
    @board = board
    @row = 0
    @column = 0
  end

  def make_move
    determine_move
    @game.make_move(@column, @row)
  end

  def best_field
    @best_field_ai = get_possible_fields[0]
    @best_field_user = get_possible_fields[0]

    get_possible_fields.each do |field|
      @value = @board.field_value(field)
      @best_field_ai = field if @value == 3 || @value == 2 || @value == 1 && @value > @board.field_value(@best_field_user)
      @best_field_user = field if @value == 15 || @value == 10 || @value == 5 && @value > @board.field_value(@best_field_ai)

    end
  end

  def determine_chosen_field
    if (@board.field_value(@best_field_ai)*5) >= @board.field_value(@best_field_user)
      return @chosen_field = @best_field_ai
    else
      return @chosen_field = @best_field_user
    end
  end

  def determine_move
    best_field
    determine_chosen_field
    determine_slot
  end

  def determine_slot
    intersection = @chosen_field & @board.available_slots
    coordinates = intersection[0]
    @column = coordinates[0]
    @row = coordinates[1]
  end

  private

  def get_possible_fields
    @possible_fields = []
    @board.available_slots.each do |slot|
      @board.fields.each {|field| @possible_fields << field if field.include?(slot) }
    end
    @possible_fields
  end



 end


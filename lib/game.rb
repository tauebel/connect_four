require_relative 'board'
require_relative 'player'


## status, history, result, check_win

class Game
  attr_reader :board
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_number = 1
    @turn = player1
    next_game
  end

  def next_game
    @board = Board.new
  end

  def next_turn
    @turn_number += 1
  end

  def turn
    if @turn_number.even?
      @turn = @player2
    else
      @turn = @player1
    end
    @turn.name
  end

  def possible_moves
    @board.available_slots
  end

  def show_board
    @board.print_board
  end

  def make_move(column, row)
    return "This is not an available move" if @board.slot_available?(column,row) == false

    if @turn == @player1
      @board.fill_slot("R", column, row)
    else
      @board.fill_slot("Y", column, row)
    end
    next_turn
  end


end
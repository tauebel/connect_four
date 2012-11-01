require_relative 'board'
require_relative 'player'


## status, history, result, check_win, possible_moves, make_move

class Game
  attr_reader
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_number = 1
    @turn = player1.name
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
      @turn = @player2.name
    else
      @turn = @player1.name
    end
    @turn
  end


end
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

  def game_won
    return "CONNECT FOUR! Congratulations #{@turn.name}, you have won in #{@turn_number/2} moves!!!"
    show_board
  end

  def game_tied
    return "This game is tied, the board has no more slots in it"
    show_board
  end

  def possible_moves
    @board.available_slots
  end

  def show_board
    @board.print_board
  end

  def to_db(column,row)
    add(@turn.id, column, row)

  end

  def win?(column,row)
    true if @board.connect_4?(column,row) == true
    false
  end

  def make_move(column, row)
    return "This is not an available move" if @board.slot_available?(column,row) == false

    if @turn == @player1
      @board.fill_slot("R", column, row)
    else
      @board.fill_slot("Y", column, row)
    end

    return game_won if win?(column,row) == true
    return game_tied if @board.full? == true

    next_turn
  end
end

game = game.new(player1, player2)
game.turn
game.make_move(4, 5)
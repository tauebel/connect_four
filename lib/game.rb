require_relative 'board'
require_relative 'player'
require_relative 'ai'


class Game
  attr_reader :board, :turn_number, :turn, :allowed, :game_won, :game_tied, :id
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @id = retrieve_id
    @turn_number = 1
    @turn = player1
    @board = Board.new
    @game_won = false
    @game_tied = false
  end

  def next_turn
    @turn_number += 1
    if @turn_number.even?
      @turn = @player2
    else
      @turn = @player1
    end
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

  def make_move(column, row)
    @allowed = true
    if @board.slot_available?(column,row) == false
      @allowed = false
      return
    end

    if @turn == @player1
      @board.fill_slot("R", column, row)
    else
      @board.fill_slot("Y", column, row)
    end


    if @board.connect_4?(column,row) == true
      Database.game_winner(self, @turn)
      return @game_won = true
    end

    return @game_tied = true if @board.full? == true

    game_move_to_db(@turn, "#{column}, #{row}")
    next_turn
  end

  private

    def game_move_to_db(turn, move)
      Database.insert_move(self, turn, move)
    end

    def retrieve_id
      Database.insert_game(@player1, @player2)
      Database.retrieve_game
    end
  end

# jake = Player.new("Jake", "Spendar89@aol.com")
# bot = Player.new("Connect This AI", "NA")
# game = Game.new(jake, bot)
# ai = AI.new(game, game.board)
# game.make_move(1,1)
# ai.make_move


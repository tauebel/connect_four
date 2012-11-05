require_relative 'twitter_board'
require_relative 'player'
require_relative 'twitter_ai'


class TwitterGame
  attr_reader :board, :turn_number, :turn, :allowed, :game_won, :game_tied, :id
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @id = retrieve_id
    @turn_number = 1
    @turn = player1
    @board = TwitterBoard.new
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

  def game_over
    Database.game_over([@player1, @player2])
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

  def get_input(column)
    @board.available_slots.each do |slot|
        if slot[0] == column
          @selected_slot = slot
          break
        end
    end

    make_move(@selected_slot[0], @selected_slot[1])
  end

  def make_move(column, row)
    @allowed = true
    if @board.slot_available?(column,row) == false
      @allowed = false
      return
    end

    if @turn == @player1
      @board.fill_slot("O", column, row)
    else
      @board.fill_slot("X", column, row)
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
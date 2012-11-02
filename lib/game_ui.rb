require_relative 'game'
require_relative 'player'

class GameUi
  def initialize
    puts "Welcome to Connect Four by Connect This"
    puts "Please enter the first player's name"
    player1_name = gets.chomp
    puts "Please enter the first player's email"
    player1_email = gets.chomp
    puts "Please enter the second player's name"
    player2_name = gets.chomp
    puts "Please enter the second player's email"
    player2_email = gets.chomp
    @player1 = Player.new(player1_name, player1_email)
    @player2 = Player.new(player2_name, player2_email)
    start_game
  end

  def start_game
    @game = Game.new(@player1, @player2)
    puts "Alright... ARE YOU READY TO RUMMMBBBBLLLEEEEE!  Ehm..."
    puts "#{@player1.name} you will be starting, your color is RED, your tokens will be marked R"
    puts "#{@player2.name} your color is YELLOW, your tokens will be marked Y"
    puts "Here's your board"
    run_game
  end

  def run_game
    while !@game.game_won && !@game.game_tied
      @game.show_board
      puts "Here are the possible moves:"
      p @game.possible_moves
      puts "#{@game.turn.name}, choose your move.  Please just type in the numbers separated by comma, no brackets."
      move = gets.chomp
      @game.make_move(move[0].to_i,move[2].to_i)
      puts "this move is not allowed" if !@game.allowed
    end
    game_end
  end

  def game_end
    if @game.game_won == true
      puts "CONNECT FOUR! Congratulations #{@game.turn.name}, you have won in #{(@game.turn_number + 1) / 2 } moves!!!"
    else
      puts "This game is tied, the board has no more slots in it"
    end
    @game.show_board

    puts "What would you like to do? Your options are exit or next game"
    decision = gets.chomp

    if decision == "next game"
      start_game
    elsif decision == "exit"
      puts "Thank you for playing"
      puts "Goodbye"
      return
    else
      puts "That was not one of your options, your options are exit or next game"
      game_end
    end
  end
end

GameUi.new
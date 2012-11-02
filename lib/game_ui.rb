require_relative 'game'

class GameUi
  def initialize
    puts "Welcome to Connect Four by Connect This"
    puts "Would you like to play a 1 or 2 player game? Please enter 1 or 2"
    choice = gets.chomp
    puts "Please enter the first player's name"
    player1_name = gets.chomp
    puts "Please enter the first player's email"
    player1_email = gets.chomp
    @player1 = Player.new(player1_name, player1_email)

    if choice == "1"
      @bot = true
    else
      @bot = false
    end

    if !@bot
      puts "Please enter the second player's name"
      player2_name = gets.chomp
      puts "Please enter the second player's email"
      player2_email = gets.chomp
      @player2 = Player.new(player2_name, player2_email)
    else
      @player2 = Player.new("Connect This", "N/A")
    end
    start_game
  end

  def start_game
    if !@bot
      @game = Game.new(@player1, @player2)
      puts "Alright... ARE YOU READY TO RUMMMBBBBLLLEEEEE!  Ehm..."
      puts "#{@player1.name} you will be starting, your color is RED, your tokens will be marked R"
      puts "#{@player2.name} your color is YELLOW, your tokens will be marked Y"
      puts "Here's your board"
      run_game
    else
      @game = Game.new(@player1, @player2)
      @ai = AI.new(@game, @game.board)
      puts "Alright... ARE YOU READY TO RUMMMBBBBLLLEEEEE!  Ehm..."
      puts "#{@player1.name} you will be starting, your color is RED, your tokens will be marked R"
      run_bot_game
    end
  end

  def run_game
    while !@game.game_won && !@game.game_tied
      @game.show_board
      puts "Here are the possible moves:"
      p @game.possible_moves
      puts "#{@game.turn.name}, your move, choose column"
      move = gets.chomp
      @game.get_input(move.to_i)
      puts "#{Color.red}#{Color.bold}this move is not allowed#{Color.clear}" if !@game.allowed
    end
    game_end
  end

    def run_bot_game
      while !@game.game_won && !@game.game_tied
        if @game.turn == @player2
          @ai.make_move
          puts "Connect This has made her ingenious move"
        else
          @game.show_board
          puts "Here are the possible moves:"
          p @game.possible_moves
          puts "#{@game.turn.name}, choose your move by column"
          move = gets.chomp
          @game.get_input(move.to_i)
          puts "#{Color.red}#{Color.bold}this move is not allowed#{Color.clear}" if !@game.allowed
        end
      end
      game_end
    end

  def game_end
    if @game.game_won == true
      puts "#{Color.green}#{Color.bold}CONNECT FOUR! Congratulations #{@game.turn.name}, you have won in #{(@game.turn_number + 1) / 2 } moves!!!#{Color.clear}"
    else
      puts "This game is tied, the board has no more slots in it"
    end
    @game.show_board
    @game.game_over
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
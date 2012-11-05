require_relative 'twitter_auth'
require_relative 'twitter_game'
require_relative 'understand_tweet'
command = ARGV

class TwitterUI

  def initialize(handle, auth_object)
    @handle = handle
    @auth = auth_object
    @started = false
    @twitter_board = "|.......|.......|.......|.......|.......|.......|"
  end

  def challenge
    Twitter.update("Who wants to get demolished? #dbc_c4 ##{rand(1000)}")
    puts "updated status"
    return
  end

  def find_challenger
    challenge
    puts "Waiting for a challenger..."
    TweetStream::Client.new.track("#{@handle} Game on! #dbc_c4") do |status|
      @opponent_name = status.user.screen_name
      break if @opponent_name != nil
    end
    @home = true
    play_game
  end

  def accept_challenge
    puts "finding game..."
    TweetStream::Client.new.track("Who wants to get demolished? #dbc_c4") do |status|
      @opponent_name = status.user.screen_name if status.user.screen_name !="longfourplay"
      break if @opponent_name != nil
    end
    @home = false
    play_game

  end

  def send_board
    puts "board:#{@twitter_board}"
    Twitter.update("@#{@opponent_name} #{@twitter_board} #dbc_c4 ##{rand(1000)}")
  end

  def play_game
    @first_move = true
    setup_game
    puts "game has begun"
    until @game.game_won || @game.game_tied
      @home == true ? game_loop_home : game_loop_away
    end
    end_game
  end

  def end_game
    last_message = "This game of connect_four is over. The winner is #{@game.turn.name}. Congrats bro."
    puts last_message
    Twitter.update("@#{@opponent_name} #{last_message} #dbc_c4 ##{rand(1000)}")
    return
  end

  def game_loop_away
    puts "#{@player1.name}:"
    their_move
    puts "#{@player2.name}:"
    your_move
  end

  def game_loop_home
    puts "#{@player1.name}:"
    your_move
    puts "#{@player2.name}:"
    their_move
  end

  def their_move
    receive_move
    if @home == true
      @understand_tweet = UnderstandTweet.new(@move, @twitter_board, false)
    else
      @understand_tweet = UnderstandTweet.new(@move, @twitter_board, true)
    end
    check_board
    @game.get_input(@get_move)
    @twitter_board = @game.board.board_string
    puts "board: #{@twitter_board}"
  end

  def check_board
    if @understand_tweet.order_error != true
      @get_move = @understand_tweet.get_column
    else
      puts "error: opponent did not correctly send its move.\nreceived board: #{@move}\nprevious board: #{@twitter_board}"
      return
    end
  end

  def your_move
    @ai.make_move
    @twitter_board = @game.board.board_string
    send_board
  end

  def setup_game
    if @home == true
      @player1 = Player.new(@handle, "#{rand(100000)}@twitter.com")
      @player2 = Player.new("@#{@opponent_name}", "#{rand(100000)}@twitter.com")
    else
      @player1 = Player.new("@#{@opponent_name}", "#{rand(100000)}@twitter.com")
      @player2 = Player.new(@handle, "#{rand(100000)}@twitter.com")
    end
    @game = TwitterGame.new(@player1, @player2)
    @ai = TwitterAI.new(@game, @game.board)
  end

  def receive_move
    Twitter.update("@#{@player1.name} Game on! #dbc_c4 ##{rand(1000)}") if @home == false && @first_move == true
    TweetStream::Client.new.track(@handle, "#dbc_c4") do |status|
      if @handle.match(status.text)
        @move = /\|.......\|.......\|.......\|.......\|.......\|.......\|/.match(status.text).to_s
        break if @move != nil
      else
        receive_move
      end
    end
    @first_move = false
  end

end

# TwitterUI.new("@jakesendar", TwitterAuth.new).accept_challenge if command[0] == "away"
TwitterUI.new("@jakesendar", TwitterAuth.new).find_challenger
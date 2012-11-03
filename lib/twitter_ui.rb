require 'game'

class TwitterUi

  def initialize
    @player1 = Player.new(player1_name, player1_email)
    @player2 = Player.new("Connect This", "N/A")
    start_game
  end

  def start_game
    @game = Game.new(@player1, @player2)
    run_twitter_game
  end

  def run_twitter_game
    while !@game.game_won && !@game.game_tied
      if @game.turn == @player2
        @ai.make_move
        out = "|"
        @game.board.slots.reverse.each {|x| out +=  "#{x.join}|"}
        puts out  #<---- to twitter
      else
        #<---- from twitter
      end
    end
    game_end
  end

end



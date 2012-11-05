#require_relative 'twitter_auth'

class UnderstandTweet
  attr_accessor :order_error

  def initialize(new_board_string, old_board_string, challenger)
    @challenger = challenger
    @new_board = new_board_string.split('|')
    @old_board = old_board_string.split('|')
    @difference_row = (@new_board - @old_board).join("")
  end

  def modified_row
      @modified_row = @new_board[@new_board.index(@difference_row)].split('')

  end

  def old_row
    @old_row = @old_board[@new_board.index(@difference_row)].split('')
  end

  def z_row
    modified_row
    old_row
    z_row = []
    7.times do |n|
      @modified_row[n] = "Z" if @modified_row[n] == @old_row[n]
      z_row << @modified_row[n]
    end
    # print @new_board
    #     puts @difference_row
    #print z_row
    z_row

  end

  def get_column
    @order_error = false
    if @challenger
      return z_row.flatten.include?("O") ? @order_error = true : z_row.index("X") + 1
    else
      return z_row.flatten.include?("X") ? @order_error = true : z_row.index("O") + 1
    end
  end

end

# old_tweet = "|.......|.......|.......|.......|.......|.......|"
# new_tweet ="|.......|.......|.......|.......|.......|......X|"
# test = UnderstandTweet.new(new_tweet, old_tweet, true)
# #puts test.z_row
# puts test.get_column
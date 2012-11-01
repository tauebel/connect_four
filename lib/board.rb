require_relative 'slot'

class Board
  attr_reader :slots_array, :available_slots
  def initialize
    @full = false
    @slots_array = generate_slots
    @available_slots = [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[7,1]]
  end

  def slot_empty?(column,row)
    @slots_array[row - 1][column - 1].empty?
  end

  def full?
    @slots_array.flatten.each {|slot| return false if slot.empty? }
    true
  end

  def slot_available?(column, row)
    @available_slots.each do |slot|
      if slot[0] == column && slot[1] == row
        return true
      end
    end
    false
  end

  def fill_slot(color,column, row)

    return "slot not available" if !slot_available?(column,row)

    @slots_array[row - 1][column - 1].fill(color)
    update_slots(column,row)
  end

  def update_slots(column,row)
    if row == 6
      @availble_slots.delete_at(column - 1)
    else
      @available_slots[column -1] = [column, row + 1]
    end
  end

  def print_board
    @slots_array.each {|row| print "#{row.inspect}\n".gsub(","," ")}
  end

private

  def generate_slots
    [[],[],[],[],[],[]].each {|row| 7.times {row << Slot.new } }
  end

end






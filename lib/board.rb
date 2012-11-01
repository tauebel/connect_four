require_relative 'slot'

class Board
  attr_reader :slots, :available_slots
  def initialize
    @full = false
    @slots = generate_slots
    @fields = generate_fields
    @available_slots = [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[7,1]]
  end

  def slot_empty?(column,row)
    slot_by_location(column,row).empty?
  end

  def full?
    @slots.flatten.each {|slot| return false if slot.empty? }
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

    slot_by_location(column,row).fill(color)
    update_slots(column,row)
  end

  def update_slots(column,row)
    if row == 6
      @available_slots.delete_at(column - 1)
    else
      @available_slots[column -1] = [column, row + 1]
    end
  end

  def print_board
    @slots.each {|row| print "#{row.inspect}\n".gsub(","," ")}
  end

  def connect_4?(column,row)
    possible_fields(column,row).each do |field|
      return true if field_value(field) == 20 || field_value(field) == 4
    end
    false
  end

  def slot_by_location(column,row)
    @slots[row - 1][column - 1]
  end

  def field_value(field)
    sum = 0
    field.each do |coordinate|
      sum += slot_by_location(coordinate[0],coordinate[1]).value
    end
    sum
  end

private

  def generate_slots
    [[],[],[],[],[],[]].each {|row| 7.times {row << Slot.new } }
  end

  def generate_fields
    [FIELD_H_1, FIELD_H_2, FIELD_H_3, FIELD_H_4, FIELD_H_5, FIELD_H_6,
         FIELD_H_7, FIELD_H_8, FIELD_H_9, FIELD_H_10, FIELD_H_11, FIELD_H_12,
         FIELD_H_13, FIELD_H_14, FIELD_H_15, FIELD_H_16, FIELD_H_17, FIELD_H_18,
         FIELD_H_19, FIELD_H_20, FIELD_H_21, FIELD_H_22, FIELD_H_23, FIELD_H_24,
         FIELD_V_1, FIELD_V_2, FIELD_V_3, FIELD_V_4, FIELD_V_5, FIELD_V_6,
         FIELD_V_7, FIELD_V_8, FIELD_V_9, FIELD_V_10, FIELD_V_11, FIELD_V_12,
         FIELD_V_13, FIELD_V_14, FIELD_V_15, FIELD_V_16, FIELD_V_17, FIELD_V_18,
         FIELD_V_19, FIELD_V_20, FIELD_V_21, FIELD_D_1, FIELD_D_2, FIELD_D_3, FIELD_D_4,
         FIELD_D_5, FIELD_D_6, FIELD_D_7, FIELD_D_8, FIELD_D_9, FIELD_D_10, FIELD_D_11,
         FIELD_D_12, FIELD_D_13, FIELD_D_14, FIELD_D_15, FIELD_D_16, FIELD_D_17, FIELD_D_18,
         FIELD_D_19, FIELD_D_20, FIELD_D_21, FIELD_D_22, FIELD_D_23, FIELD_D_24]
  end

  def possible_fields(column, row)
    possible_fields = []
    @fields.each do |field|
      if field.include?([column,row]) == true
        possible_fields << field
      end
    end
    possible_fields
  end
end

FIELD_H_1 = [[1,1], [2,1], [3,1], [4,1]]
FIELD_H_2 = [[2,1], [3,1], [4,1], [5,1]]
FIELD_H_3 = [[3,1], [4,1], [5,1], [6,1]]
FIELD_H_4 = [[4,1], [5,1], [6,1], [7,1]]


FIELD_H_5 = [[1,2], [2,2], [3,2], [4,2]]
FIELD_H_6 = [[2,2], [3,2], [4,2], [5,2]]
FIELD_H_7 = [[3,2], [4,2], [5,2], [6,2]]
FIELD_H_8 = [[4,2], [5,2], [6,2], [7,2]]


FIELD_H_9 = [[1,3], [2,3], [3,3], [4,3]]
FIELD_H_10 = [[2,3], [3,3], [4,3], [5,3]]
FIELD_H_11 = [[3,3], [4,3], [5,3], [6,3]]
FIELD_H_12 = [[4,3], [5,3], [6,3], [7,3]]


FIELD_H_13 = [[1,4], [2,4], [3,4], [4,4]]
FIELD_H_14 = [[2,4], [3,4], [4,4], [5,4]]
FIELD_H_15 = [[3,4], [4,4], [5,4], [6,4]]
FIELD_H_16 = [[4,4], [5,4], [6,4], [7,4]]


FIELD_H_17 = [[1,5], [2,5], [3,5], [4,5]]
FIELD_H_18 = [[2,5], [3,5], [4,5], [5,5]]
FIELD_H_19 = [[3,5], [4,5], [5,5], [6,5]]
FIELD_H_20 = [[4,5], [5,5], [6,5], [7,5]]


FIELD_H_21 = [[1,6], [2,6], [3,6], [4,6]]
FIELD_H_22 = [[2,6], [3,6], [4,6], [5,6]]
FIELD_H_23 = [[3,6], [4,6], [5,6], [6,6]]
FIELD_H_24 = [[4,6], [5,6], [6,6], [7,6]]

FIELD_V_1 = [[1,1], [1,2], [1,3], [1,4]]
FIELD_V_2 = [[1,2], [1,3], [1,4], [1,5]]
FIELD_V_3 = [[1,3], [1,4], [1,5], [1,6]]


FIELD_V_4 = [[2,1], [2,2], [2,3], [2,4]]
FIELD_V_5 = [[2,2], [2,3], [2,4], [2,5]]
FIELD_V_6 = [[2,3], [2,4], [2,5], [2,6]]

FIELD_V_7 = [[3,1], [3,2], [3,3], [3,4]]
FIELD_V_8 = [[3,2], [3,3], [3,4], [3,5]]
FIELD_V_9 = [[3,3], [3,4], [3,5], [3,6]]

FIELD_V_10 = [[4,1], [4,2], [4,3], [4,4]]
FIELD_V_11 = [[4,2], [4,3], [4,4], [4,5]]
FIELD_V_12 = [[4,3], [4,4], [4,5], [4,6]]

FIELD_V_13 = [[5,1], [5,2], [5,3], [5,4]]
FIELD_V_14 = [[5,2], [5,3], [5,4], [5,5]]
FIELD_V_15 = [[5,3], [5,4], [5,5], [5,6]]

FIELD_V_16 = [[6,1], [6,2], [6,3], [6,4]]
FIELD_V_17 = [[6,2], [6,3], [6,4], [6,5]]
FIELD_V_18 = [[6,3], [6,4], [6,5], [6,6]]

FIELD_V_19 = [[7,1], [7,2], [7,3], [7,4]]
FIELD_V_20 = [[7,2], [7,3], [7,4], [7,5]]
FIELD_V_21 = [[7,3], [7,4], [7,5], [7,6]]

FIELD_D_1 = [[1,3], [2,4], [3,5], [4,6]]
FIELD_D_2 = [[1,2], [2,3], [3,4], [4,5]]
FIELD_D_3 = [[2,3], [3,4], [4,5], [5,6]]

FIELD_D_4 = [[1,1], [2,2], [3,3], [4,4]]
FIELD_D_5 = [[2,2], [3,3], [4,4], [5,5]]
FIELD_D_6 = [[3,3], [4,4], [5,5], [6,6]]

FIELD_D_7 = [[2,1], [3,2], [4,3], [5,4]]
FIELD_D_8 = [[3,2], [4,3], [5,4], [6,5]]
FIELD_D_9 = [[4,3], [5,4], [6,5], [7,6]]

FIELD_D_10 = [[3,1], [4,2], [5,3], [6,4]]
FIELD_D_11 = [[4,2], [5,3], [6,4], [7,5]]
FIELD_D_12 = [[4,1], [5,2], [6,3], [7,4]]

FIELD_D_13 = [[1,4], [2,3], [3,2], [4,1]]
FIELD_D_14 = [[1,5], [2,4], [3,3], [4,2]]
FIELD_D_15 = [[2,4], [3,3], [4,2], [5,1]]

FIELD_D_16 = [[1,6], [2,5], [3,4], [4,3]]
FIELD_D_17 = [[2,5], [3,4], [4,3], [5,2]]
FIELD_D_18 = [[3,4], [4,3], [5,2], [6,1]]

FIELD_D_19 = [[2,6], [3,5], [4,4], [5,3]]
FIELD_D_20 = [[3,5], [4,4], [5,3], [6,2]]
FIELD_D_21 = [[4,4], [5,3], [6,2], [7,1]]

FIELD_D_22 = [[3,6], [4,5], [5,4], [6,3]]
FIELD_D_23 = [[4,5], [5,4], [6,3], [7,2]]
FIELD_D_24 = [[4,6], [5,5], [6,4], [7,3]]






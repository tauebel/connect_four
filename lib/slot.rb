class Slot
  attr_reader :color
  def initialize
    @color = nil
    @empty = true
  end

  def empty?
    @empty
  end

  def fill(color)
    return "already filled" if empty? == false
    @empty = false
    @color = color
  end



end
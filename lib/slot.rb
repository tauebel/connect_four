require 'term/ansicolor'

class Color
  extend Term::ANSIColor
end

class Slot
  attr_reader :color, :value

  def initialize
    @color = nil
    @empty = true
    @value = 0
  end

  def empty?
    @empty
  end

  def fill(color)
    return "already filled" if empty? == false
    @empty = false
    @color = color
    color == "R" ? @value = 1 : @value = 5
  end

  def to_s
    if @empty
      "-"
    else
      if self.color == "R"
        "#{Color.red}#{Color.bold}#{self.color}#{Color.clear}"
      else
        "#{Color.yellow}#{Color.bold}#{self.color}#{Color.clear}"
      end
    end
  end



end
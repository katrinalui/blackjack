class ComputerPlayer
  attr_accessor :hand, :name, :hold

  def initialize(name = 'Computer')
    @name = name
    @hand = {}
    @hold = false
  end

  def total
    @hand.values.reduce(:+)
  end

  def get_move
    total < 16 ? "hit" : "hold"
  end

  def bust?
    total > 21
  end
end

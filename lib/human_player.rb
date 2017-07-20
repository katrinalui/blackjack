class HumanPlayer
  attr_accessor :hand, :name, :hold

  def initialize(name)
    @name = name
    @hand = {}
    @hold = false
  end

  def total
    @hand.values.reduce(:+)
  end

  def get_move
    puts "Your current hand: #{hand.keys}"
    print 'Do you want to hit or hold? '
    gets.chomp
  end

  def bust?
    total > 21
  end
end

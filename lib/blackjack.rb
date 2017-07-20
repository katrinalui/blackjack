require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

class Blackjack
  SUITS = ["H", "C", "S", "D"].freeze
  CARD_NUMBER = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze
  VALUES = {
    A: 11,
    J: 10,
    Q: 10,
    K: 10
  }.freeze

  def initialize(*players)
    @all_players = players
    @dealt_cards = []
  end

  def play
    setup

    @all_players.each do |player|
      until player.bust? || player.hold
        take_turn(player)
      end
    end

    puts "The winner is #{winner}!"
  end

  # deals first two cards to every player
  def setup
    @all_players.each do |player|
      deal(player, 2)
    end
  end

  def take_turn(player)
    move = player.get_move
    if move == "hit"
      deal(player, 1)
    elsif move == "hold"
      player.hold = true
    end
  end

  def deal(player, num_cards)
    num_cards.times do
      card = random_card

      while dealt?(card)
        card = random_card
      end

      player.hand[card] = value(card)
      @dealt_cards << card
    end
  end

  def random_card
    number = CARD_NUMBER.sample
    suit = SUITS.sample
    "#{number}#{suit}"
  end

  def dealt?(card)
    @dealt_cards.include?(card)
  end

  def value(card)
    card_value = card.chop
    if VALUES.key?(card_value.to_sym)
      VALUES[card_value.to_sym]
    else
      card_value.to_i
    end
  end

  def winner
    potential_winners = @all_players.reject(&:bust?)
    highest = potential_winners.reduce do |winner, player|
      if player.total > winner.total
        player
      else
        winner
      end
    end

    highest.name
  end
end

if $0 == __FILE__
  print "Please enter your name: "
  player_one = HumanPlayer.new(gets.chomp)
  player_two = ComputerPlayer.new
  game = Blackjack.new(player_one, player_two)
  game.play
end

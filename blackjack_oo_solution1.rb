# Object Oriented Blackjack game

# 1) Abstraction
# 2) Encapsulation

class Card
  attr_accessor :suit, :face_value

  def initialize(s, fv)
    @suit = s
    @face_value = fv
  end

  def pretty_output
    puts "The #{@face_value} of #{@suit}"
  end
end

class Deck
end

class Player
end

class Dealer
end

class Hand
end

c1 = Card.new('H','3')
c2 = Card.new('D', '4')

c1.pretty_output
c2.pretty_output

puts c1.suit
puts c2.suit

c1.suit = "New Suit for C1"
c2.suit = "New Suit for c2"

puts c1.suit
puts c2.suit
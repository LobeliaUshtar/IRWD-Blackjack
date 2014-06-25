require_relative 'card'

class Deck
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  SUITS = ["\u2660", "\u2665", "\u2663", "\u2666"]

  attr_accessor :cards

  def initialize(num_decks=1)
    @cards = []
    SUITS.each do |suit|
      VALUES.each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    @cards = @cards * num_decks
    shuffling
  end

  def shuffling
    cards.shuffle!
  end

  def deal
    cards.pop
  end

  def size
    cards.size
  end
end
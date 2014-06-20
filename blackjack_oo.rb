class Card
  def initialize(value, suit)
    @suit = suit
    @value = value
  end

  def to_s
    "The card: #{@value} of #{@suit}"
  end
end

class Deck
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  SUITS = ['Hearts', 'Diamonds', 'Spades', 'Clubs']

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
end

# class Player
#   def get_name
#     puts "\nWhat is your name?"
#     @player = gets.chomp.capitalize
#     puts "Hello #{@player}, let's get playing."
#   end

#   get_name
# end

# class Dealer
  
# end

module Hand
  def calculate_total(cards)
    hand = cards.map { |card| card[1] }

    total = 0
    hand.each do |value|
      if value == 'A'
        total += 11
      elsif value.to_i == 0 # for J, Q, K
        total += 10
      else
        total += value.to_i
      end
    end

    hand.select { |card| card == 'A' }.count.times do
      total -= 10 if total > 21
    end

    total
  end

  def show_hand
    
  end
end

# class Game
#   attr_accessor :player, :dealer, :deck

#   def initialize
#     @player = Player.new('Bob')
#     @dealer = Dealer.new
#     @deck = Deck.new
#   end
  
# end



deck = Deck.new
deck.shuffling
deck.deal
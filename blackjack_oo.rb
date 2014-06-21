class Card
  attr_accessor :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "#{face} of #{suit}"
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
    @dealt_card
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

module Hand
  def total
    hand = cards.map { |card| card.face}

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
    puts "\n--- #{name}'s Hand ---"
    cards.each do |card|
      puts "\t#{card}"
    end
    puts "#{name}'s Total: #{total}"
  end

  def add_card(new_card)
    cards << new_card
  end

  def busted?
    total > 21
  end
end

class Player
  include Hand

  attr_reader :name
  attr_accessor :cards

  def initialize(name)
    @name = name.capitalize
    @cards = []
  end
end

class Dealer
  include Hand

  attr_reader :name
  attr_accessor :cards

  def initialize
    @name = 'Dealer'
    @cards = []
  end
  
end

class Game
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new('Bob')
    @dealer = Dealer.new
    @deck = Deck.new
  end
  
end

deck = Deck.new

player = Player.new('chris')
2.times do
  player.add_card(deck.deal)
end
player.show_hand

dealer = Dealer.new
2.times do
  player.add_card(deck.deal)
end
dealer.show_hand
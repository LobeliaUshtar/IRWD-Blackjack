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

  def is_busted?
    total > Blackjack::BLACKJACK_AMOUNT
  end
end

class Player
  include Hand

  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def show_initial
    show_hand
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

  def show_initial
    puts "\n--- #{name}'s Hand ---"
    puts "\tHIDDEN"
    puts "\t#{cards[1]}"
    # puts "#{name}'s Total: #{total}"
  end
end

class Blackjack
  attr_accessor :deck, :player, :dealer

  BLACKJACK_AMOUNT = 21
  DEALER_HIT_MIN = 17

  def initialize
    @deck = Deck.new
    @player = Player.new('Player1')
    @dealer = Dealer.new
  end

  def set_player_name
    puts "What is your name?"
    player.name = gets.chomp.capitalize
  end

  def initial_deal
    2.times do
      player.add_card(deck.deal)
      dealer.add_card(deck.deal)
    end
  end

  def show_hands
    player.show_initial
    dealer.show_initial
  end

  def blackjack_or_bust?(player_or_dealer)
    puts "\n"
    if player_or_dealer.total == BLACKJACK_AMOUNT
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry, dealer hit blackjack and #{player.name} losses. =("
      else
        puts "Congrats, #{player.name} hit balckjack and wins. =)"
      end
      play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        puts "Congrats, dealer busted and #{player.name} wins. =)"
      else
        puts "Sorry, #{player.name} busted and loss. =("
      end
      play_again?
    end
  end

  def player_turn
    puts "\n#{player.name}'s turn."
    
    blackjack_or_bust?(player)
    while !player.is_busted?
      puts "\nWhat would you like to do? 1) hit 2) stay"
      response = gets.chomp.to_i
      if ![1, 2].include?(response)
        puts "ERROR: you must enter 1 or 2"
        next
      end

      if response == 2
        puts "#{player.name} chose to stay."
        player.show_hand
        break
      end

      new_card = deck.deal
      puts "Dealing card to #{player.name}: #{new_card}"
      player.add_card(new_card)
      puts "#{player.name}'s Updated Total: #{player.total}"
      blackjack_or_bust?(player)
    end
    puts "#{player.name} stays at #{player.total}."
  end

  def dealer_turn
    puts "\nDealer's turn."
    
    blackjack_or_bust?(dealer)
    while dealer.total < DEALER_HIT_MIN
      new_card = deck.deal
      puts "Dealing card to dealer: #{new_card}"
      dealer.add_card(new_card)
      dealer.show_hand
      blackjack_or_bust?(dealer)
    end
    puts "Dealer stays at #{dealer.total}."
  end

  def winner?
    if player.total > dealer.total
      puts "\nCongrats, #{player.name} wins!"
    elsif player.total < dealer.total
      puts "\nSorry, #{player.name} loses!"
    else
      puts "\nIt's a tie!"
    end
    play_again?
  end

  def play_again?
    puts "\nWould you like to play again? YES or NO"
    if gets.chomp.upcase == 'YES'
      puts "Starting new game..."
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      start
    else
      puts "Goodbye!"
      exit
    end
  end
  
  def start
    system 'clear'
    puts "Welcome to Blackjack!"
    set_player_name
    initial_deal
    show_hands
    player_turn
    dealer_turn
    winner?
  end
end

game = Blackjack.new
game.start
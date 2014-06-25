require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'player'
require_relative 'dealer'

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
      puts "What would you like to do? 1) hit 2) stay"
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
    
    dealer.show_hand
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
      puts "\nStarting new game..."
      deck = Deck.new
      player.cards = []
      dealer.cards = []
      puts "\nHere we go again, #{player.name}!"
      play
    else
      puts "\nGoodbye!"
      exit
    end
  end
  
  def play
    initial_deal
    show_hands
    player_turn
    dealer_turn
    winner?
  end

  def start
    system 'clear'
    puts "Welcome to Blackjack!"
    set_player_name
    play
  end
end

game = Blackjack.new
game.start
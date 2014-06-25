require_relative 'card'
require_relative 'deck'

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
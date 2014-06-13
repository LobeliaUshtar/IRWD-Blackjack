# Interactive command line blackjack game

def calculate_total(cards)
  # [["H", "3"], ["S", "J"], ...
  arr = cards.map { |e| e[1] }

  total = 0
  arr.each do |value|
    if value == 'A'
      total += 11
    elsif value.to_i == 0 # for J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end

  # correct for Aces

  arr.select { |e| e == 'A' }.count.times do
    total -= 10 if total > 21
  end

  total
end

system 'clear'
#Start Game
puts "Welcome to Blackjack!"

suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

# Deal cards

playercards = []
dealercards = []

playercards << deck.pop
dealercards << deck.pop
playercards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
playertotal = calculate_total(playercards)

# Show cards

puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of: #{dealertotal}"
puts "Player has: #{playercards[0]} and #{playercards[1]}, for a total of: #{playertotal}"

# Player Turn

if playertotal == 21
  puts "Congratulations, player hit blackjack! Player wins!"
  exit
end

while playertotal < 21
  puts "\nWhat would you like to do? 1) hit 2) stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "ERROR: you must enter 1 or 2"
    next
  end

  if hit_or_stay == '2'
    puts "Player chose to stay."
    break
  end

  # hit
  new_card = deck.pop
  puts "Dealing new card to player: #{new_card}"
  playercards << new_card
  playertotal = calculate_total(playercards)
  puts "Player total is now: #{playertotal}"

  if playertotal == 21
    puts "Congratulations, player hit blackjack! Player wins!"
    exit
  elsif playertotal > 21
    puts "Sorry, player busted! Dealer wins!"
    exit
  end
end

# Dealer Turn

if dealertotal == 21
  puts "Sorry, dealer hit blackjack! Player loses!"
  exit
end

while dealertotal < 17
  # hit
  new_card = deck.pop
  puts "Dealing new card to dealer: #{new_card}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  puts "Dealer total is now: #{dealertotal}"

  if dealertotal == 21
    puts "Sorry, dealer hit blackjack! Player loses!"
    exit
  elsif dealertotal > 21
    puts "Congratulations, dealer busted! Player wins!"
    exit
  end
end

#  Compare hands

puts "\nDealer's cards: total of #{dealertotal}"
dealercards.each do |card|
  puts "=> #{card}"
end

puts "\nPlayer's cards: total of #{playertotal}"
playercards.each do |card|
  puts "=> #{card}"
end

if playertotal > dealertotal
  puts "Congratulations, Player won!"
elsif playertotal < dealertotal
  puts "Sorry, Dealer won!"
else
  puts "We have a tie."
end
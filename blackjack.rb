system 'clear'
puts "Welcome to Blackjack!"

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

suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suits.product(cards)
deck.shuffle!

def get_name
  puts "\nWhat is your name?"
  @player = gets.chomp.capitalize
  puts "Hello #{@player}, let's get playing."
end

get_name

playercards = []
dealercards = []

playercards << deck.pop
dealercards << deck.pop
playercards << deck.pop
dealercards << deck.pop

dealertotal = calculate_total(dealercards)
playertotal = calculate_total(playercards)

puts "\nDealer's cards: total of #{dealertotal}"
dealercards.each do |card|
  puts "=> #{card}"
end

puts "\n#{@player}'s cards: total of #{playertotal}"
playercards.each do |card|
  puts "=> #{card}"
end

if playertotal == 21
  puts "Congratulations, #{player}! You hit blackjack! #{player} wins!"
  exit
end

while playertotal < 21
  puts "\nWhat would you like to do? 1) hit 2) stay"
  hit_or_stay = gets.chomp.to_i

  if ![1, 2].include?(hit_or_stay)
    puts "ERROR: you must enter 1 or 2"
    next
  end

  if hit_or_stay == 2
    puts "Player chose to stay."
    break
  end

  new_card = deck.pop
  puts "Dealing new card to #{@player}: #{new_card}"
  playercards << new_card
  playertotal = calculate_total(playercards)
  puts "#{@player}'s' total is now: #{playertotal}"

  if playertotal == 21
    puts "Congratulations, #{@player}! You hit blackjack! #{@player} wins!"
    exit
  elsif playertotal > 21
    puts "Sorry, #{@player}... you busted! Dealer wins!"
    exit
  end
end

if dealertotal == 21
  puts "Sorry, the dealer hit blackjack! #{@player} loses!"
  exit
end

while dealertotal < 17
  new_card = deck.pop
  puts "Dealing new card to dealer: #{new_card}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  puts "Dealer's total is now: #{dealertotal}"

  if dealertotal == 21
    puts "Sorry, the dealer hit blackjack! #{@player} loses!"
    exit
  elsif dealertotal > 21
    puts "Congratulations, the dealer busted! #{@player} wins!"
    exit
  end
end

puts "\nDealer's cards: total of #{dealertotal}"
dealercards.each do |card|
  puts "=> #{card}"
end

puts "\n#{@player}'s cards: total of #{playertotal}"
playercards.each do |card|
  puts "=> #{card}"
end

if playertotal > dealertotal
  puts "Congratulations, #{@player}! You won!"
elsif playertotal < dealertotal
  puts "Sorry, Dealer won!"
else
  puts "We have a tie."
end
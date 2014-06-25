require_relative 'hand'

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
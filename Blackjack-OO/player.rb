require_relative 'hand'

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
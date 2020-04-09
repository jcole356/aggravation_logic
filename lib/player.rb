# frozen_string_literal: true

# Class for player logic
class Player
  attr_reader :name, :current_hand

  OPTIONS = {
    d: 'Deck',
    p: 'Pile'
  }.freeze

  def initialize(name)
    @name = name
    @current_hand = 0
    @score = 0
  end

  def draw
    choice = gets.chomp
    puts ''
    puts "Drawing from the #{Player::OPTIONS[choice.to_sym]}"
    puts ''
  end

  def hand(hand = nil)
    @hand ||= hand
  end

  def take_turn
    puts "Draw from #{Player::OPTIONS[:d]} (D) or #{Player::OPTIONS[:p]} (P)"
    draw
  end
end

# frozen_string_literal: true

# Class for player logic
class Player
  attr_reader :name, :current_hand

  def initialize(name)
    @name = name
    @current_hand = 0
  end

  def hand(hand)
    @hand ||= hand
  end
end

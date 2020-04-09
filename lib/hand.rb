# frozen_string_literal: true

# Class for the player's hand
class PlayerHand
  attr_reader :sets, :runs, :cards

  def initialize(cards, sets = nil, runs = nil)
    @sets = sets
    @runs = runs
    @cards = cards
    @down = false
    @piles = []
  end

  # Will be replaced by client code
  def render
    cards.each(&:render)
  end
end

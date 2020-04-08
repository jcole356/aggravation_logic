# frozen_string_literal: true

# TODO: will probably also need a game hand
# Class for the player's hand
class PlayerHand
  attr_reader :sets, :runs

  def initialize(sets = nil, runs = nil)
    @sets = sets
    @runs = runs
    # @cards = cards
    # @down = false
    # @piles = []
  end
end

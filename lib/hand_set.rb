# frozen_string_literal: true

# Class for defining set (avoids naming collision with Ruby Set)
class HandSet
  attr_reader :num_cards, :cards

  def initialize(num_cards)
    @num_cards = num_cards
    @cards = []
  end

  def play(card)
    raise 'Invalid Move' unless valid_move?(card)

    cards << card
  end

  # TODO: check other cards
  def valid_move?(_card)
    return true if cards.empty?
  end
end

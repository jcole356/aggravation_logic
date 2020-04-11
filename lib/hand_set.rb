# frozen_string_literal: true

# Class for defining set (avoids naming collision with Ruby Set)
class HandSet
  attr_reader :num_cards, :cards

  def initialize(num_cards)
    @num_cards = num_cards
    @cards = []
  end

  def complete?
    cards.length >= num_cards
  end

  def play(card)
    raise 'Invalid Move' unless valid_move?(card)

    cards << card
  end

  def valid_move?(card)
    if cards.length < 2
      return false if card.wild?
    end

    return true if cards.empty?

    card.matches?(cards.last)
  end
end

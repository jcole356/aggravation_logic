# frozen_string_literal: true

# Class for defining set (avoids naming collision with Ruby Set)
class HandSet
  attr_reader :num_cards, :cards
  attr_accessor :value

  def initialize(num_cards)
    @num_cards = num_cards
    @cards = []
    @value = nil
  end

  def complete?
    cards.length >= num_cards
  end

  def play(card)
    raise('Invalid Move') && return unless valid_move?(card)

    value ||= card.value

    card.current_value(value) if card.wild?

    cards << card
  end

  def valid_move?(card)
    if cards.length < 2
      return false if card.wild?
    end

    return true if cards.empty?

    card.wild? || card.value == value
  end
end

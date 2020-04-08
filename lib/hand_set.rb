# frozen_string_literal: true

# Class for defining set (avoids naming collision with Ruby Set)
class HandSet
  attr_reader :num_cards

  def initialize(num_cards)
    @num_cards = num_cards
  end
end

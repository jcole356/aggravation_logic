# frozen_string_literal: true

# Class for the discard pile
class Pile
  attr_reader :cards

  def initialize
    @cards = []
  end

  def empty?
    cards.empty?
  end

  def last
    cards.last
  end
end

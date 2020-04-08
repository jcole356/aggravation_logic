# frozen_string_literal: true

# Class for building decks and card logic
class Wild < Card
  def initialize(suit, value)
    super
    @current_suit = nil
    @current_value = nil
  end

  def points
    20
  end

  def rank
    super(current_value)
  end

  def current_suit(suit = nil)
    @current_suit ||= suit
  end

  def current_value(value = nil)
    @current_value ||= value
  end

  def wild?
    true
  end
end

# frozen_string_literal: true

# Class for building decks and card logic
class Wild < Card
  def initialize(suit, value)
    super
    @current_suit = nil
    @current_value = nil
  end

  # TODO
  def next?(prev_card); end

  # TODO
  def ranks; end

  def current_suit(value)
    @current_suit ||= value
  end

  def current_value(value)
    @current_value ||= value
  end

  def wild?
    true
  end
end

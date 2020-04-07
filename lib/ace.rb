# frozen_string_literal: true

# Class for building decks and card logic
class Ace < Card
  def initialize
    super
    @current_value = nil
  end

  # TODO
  def next?(prev_card); end

  # TODO
  def ranks; end

  def current_value(value)
    @current_value ||= value
  end

  def wild?
    false
  end
end

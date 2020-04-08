# frozen_string_literal: true

# TODO: hardcode the value here
class Ace < Card
  def initialize(suit, value)
    super
    @current_value = nil
  end

  def points
    15
  end

  # TODO: this one is trickier
  # Not sure how to handle the higher point case
  def rank
    super(current_value)
  end

  def current_value(value = nil)
    @current_value ||= value
  end

  def wild?
    false
  end
end

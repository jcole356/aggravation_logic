# frozen_string_literal: true

# Class for building decks and card logic
class Card
  attr_reader :suit, :value

  SUITS = {
    diamonds: 'D',
    hearts: 'H',
    spades: 'S',
    clubs: 'C'
  }.freeze

  VALUES = {
    ace: 'A',
    two: '2',
    three: '3',
    four: '4',
    five: '5',
    six: '6',
    seven: '7',
    eight: '8',
    nine: '9',
    ten: '10',
    jack: 'J',
    queen: 'Q',
    king: 'K'
  }.freeze

  WILD = {
    two: '2',
    joker: 'JOKER'
  }.freeze

  def initialize(suit, value)
    @suit = suit
    @value = value
    @current_value = nil
  end

  def self.suits
    SUITS.values
  end

  def self.values
    VALUES.values
  end

  def self.wild_cards
    WILD.values
  end

  # Builds the standard deck
  def self.all_cards
    all_cards = []
    suits.each do |suit|
      values.each do |value|
        all_cards << Card.new(suit, value)
      end
    end
    2.times { all_cards << Card.new(nil, WILD[:joker]) }
    all_cards
  end

  def wild?
    Card.wild_cards.include?(value)
  end

  def rank
    value_idx = Card.values.index(value)
    return [value_idx + 1, Card.values.length + 1] if value == VALUES[:ace]
    return '*' if wild?

    [value_idx + 1]
  end
end

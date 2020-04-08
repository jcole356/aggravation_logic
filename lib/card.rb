# frozen_string_literal: true

require 'pry'

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

  # TODO: Wild card should probably be a subclass
  # TODO: Ace should probably be it's own class too
  WILD = {
    two: '2',
    joker: 'JOKER'
  }.freeze

  def initialize(suit, value)
    @suit = suit
    @value = value
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

  def matches?(card)
    wild? || card.wild? || value == card.value
  end

  # Can the current card be played next in a run
  # TODO: need to check the current suit (maybe on wilds)
  def next?(prev_card)
    return false unless same_suit?(prev_card)

    rank == prev_card.rank + 1
  end

  def points
    rank > 7 ? 10 : 5
  end

  # Actual rank of card
  def rank(current_value = value)
    value_idx = Card.values.index(current_value)
    ranks = (1..Card.values.length + 1).to_a # TODO
    ranks[value_idx]
  end

  # Possible ranks of all cards
  def ranks
    (1..Card.values.length + 1).to_a
  end

  def same_suit?(card)
    current_suit == card.current_suit
  end

  def current_suit
    suit
  end

  def current_value
    value
  end

  def wild?
    false
  end
end

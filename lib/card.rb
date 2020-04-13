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

  SPECIAL = {
    ace_high: 'AH'
  }.freeze

  WILD = {
    two: '2',
    joker: 'JOKER'
  }.freeze

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def self.special
    SPECIAL.values
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
  # rubocop:disable Metrics/MethodLength
  def self.all_cards
    all_cards = []
    suits.each do |suit|
      values.each do |value|
        all_cards << if value == Card::VALUES[:two]
                       Wild.new(suit, value)
                     elsif value == Card::VALUES[:ace]
                       Ace.new(suit)
                     else
                       Card.new(suit, value)
                     end
      end
    end
    2.times { all_cards << Wild.new(nil, WILD[:joker]) }
    all_cards
  end
  # rubocop:enable Metrics/MethodLength

  def display_name
    "#{value}#{suit}"
  end

  # TODO: may not need this
  def matches?(card)
    wild? || card.wild? || current_value == card.current_value
  end

  # Can the current card be played next in a run
  # TODO: this may belong in the Run class
  def next?(prev_card)
    return false unless same_suit?(prev_card)

    rank == prev_card.rank + 1
  end

  def points
    rank > 7 ? 10 : 5
  end

  # TODO: maybe a class method
  def possible_ranks
    Card.values + Card.special
  end

  # Actual rank of card
  def rank(current_value = value)
    value_idx = possible_ranks.index(current_value)
    ranks[value_idx]
  end

  # Possible ranks of all cards
  # TODO: maybe a class method
  def ranks
    (1..possible_ranks.length).to_a
  end

  # Will be replaced by client code
  def render
    puts display_name
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

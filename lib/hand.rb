# frozen_string_literal: true

# Class for the player's hand
class PlayerHand
  attr_reader :sets, :runs, :cards
  attr_accessor :down

  HANDS = [
    { sets: [2, 3] },
    { runs: [2, 4, true] }
  ].freeze

  def initialize(cards, sets = nil, runs = nil)
    @sets = sets
    @runs = runs
    @cards = cards
    @down = false
  end

  # Factory method
  def self.build(hand_idx, deck)
    current_hand = PlayerHand::HANDS[hand_idx]
    sets = build_sets(current_hand[:sets])
    runs = build_runs(current_hand[:runs])
    new(deck.cards.slice!(0, 11), sets, runs)
  end

  # TODO: add tests
  def self.build_runs(runs)
    return nil if runs.nil?

    result = {}
    runs.first.times do
      result["r#{idx}".to_sym] = Run.new(runs[1], runs[2])
    end
    result
  end

  # TODO: add tests
  def self.build_sets(sets)
    return nil if sets.nil?

    result = {}
    sets.first.times do |idx|
      result["s#{idx}".to_sym] = HandSet.new(sets[1])
    end
    result
  end

  def self.render(hand_idx)
    current_hand = PlayerHand::HANDS[hand_idx]
    sets = current_hand[:sets]
    runs = current_hand[:runs]
    sets_string = sets.nil? ? sets : "#{sets[0]} sets of #{sets[1]}"
    runs_string = runs.nil? ? runs : ", #{runs[0]} runs of #{runs[1]}"
    same_suit = runs && runs[3] ? ' same suit' : nil
    puts "#{sets_string}#{runs_string}#{same_suit}"
  end

  def max_size
    17
  end

  # TODO: utils for rendering an array of cards
  def render
    puts cards.map.with_index { |card, idx| "(#{idx}) #{card.display_name}" }
              .join(', ')
    puts ''
  end

  def render_piles
    sets&.each do |key, set|
      puts "(#{key.to_s.upcase}) Set of #{set.num_cards}"
      puts set.cards.map(&:display_name).join(' ')
    end
    runs&.each do |key, run|
      puts "(#{key.to_s.upcase}) Set of #{run.num_cards}"
      puts run.cards.map(&:display_name).join(' ')
    end
  end

  def select_card(idx)
    cards[idx]
  end

  def remove_card(card)
    cards.delete(card)
    card
  end
end

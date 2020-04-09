# frozen_string_literal: true

# Class for game logic
class Game
  attr_reader :players, :deck

  HANDS = [
    { sets: [3, 3] },
    { runs: [2, 4, true] }
  ].freeze

  # TODO: figure out how many players require a third deck
  # TODO: need to reshuffle the discard pile when the deck is empty
  def initialize
    @players = []
    @deck = Deck.new(2)
    @deck.shuffle
  end

  def build_hand(player)
    current_hand = Game::HANDS[player.current_hand]
    sets = build_sets(current_hand[:sets])
    runs = build_runs(current_hand[:runs])
    PlayerHand.new(deck.cards.slice(0, 11), sets, runs)
  end

  def build_runs(runs)
    return nil if runs.nil?

    result = []
    runs.first.times do
      Run.new(runs[1], runs[2])
    end
    result
  end

  def build_sets(sets)
    return nil if sets.nil?

    result = []
    sets.first.times do
      HandSet.new(sets[1])
    end
    result
  end

  def deal
    players.each do |player|
      player.hand(build_hand(player))
    end
  end

  # TODO: the following
  # Turns
  # Steals
  # Discard
  # Draw
  # rubocop:disable Metrics/MethodLength
  def play # rubocop:disable Metrics/AbcSize
    puts 'How many players'
    puts ''
    num_players = gets.chomp.to_i
    num_players.times do
      puts 'Please enter your name'
      puts ''
      name = gets.chomp
      @players << Player.new(name)
    end
    deal
    # This is mostly for dev
    players.each do |player|
      puts ''
      puts "#{player.name}'s cards:"
      puts ''
      players.first.hand.render
    end
  end
  # rubocop:enable Metrics/MethodLength
end

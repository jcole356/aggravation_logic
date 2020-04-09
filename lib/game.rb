# frozen_string_literal: true

# Class for game logic
class Game
  attr_reader :players, :deck

  # TODO: maybe this belongs in Hand
  HANDS = [
    { sets: [2, 3] },
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
    PlayerHand.new(deck.cards.slice!(0, 11), sets, runs)
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
  # rubocop:disable Metrics/AbcSize
  def play
    puts ''
    puts 'How many players'
    num_players = gets.chomp.to_i
    puts ''
    num_players.times do
      puts 'Please enter your name'
      name = gets.chomp
      puts ''
      @players << Player.new(name)
    end
    deal
    # This is mostly for dev
    players.each do |player|
      puts ''
      puts "#{player.name}'s cards:"
      puts ''
      render_hand(player)
    end
  end

  # TODO: clean up the repetition here
  def render_hand(player)
    player.hand.render
    puts ''
    current_hand = Game::HANDS[player.current_hand]
    sets = current_hand[:sets]
    runs = current_hand[:runs]
    sets_string = sets.nil? ? sets : "#{sets[0]} sets of #{sets[1]}"
    runs_string = runs.nil? ? runs : ", #{runs[0]} runs of #{runs[1]}"
    same_suit = runs && runs[3] ? ' same suit' : nil
    puts "#{sets_string}#{runs_string}#{same_suit}"
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize
end

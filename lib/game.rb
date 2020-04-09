# frozen_string_literal: true

# Class for game logic
class Game
  attr_reader :players, :deck

  # TODO: figure out how many players require a third deck
  # TODO: need to reshuffle the discard pile when the deck is empty
  def initialize
    @players = []
    @deck = Deck.new(2)
    @deck.shuffle
  end

  def build_hand(player)
    PlayerHand.build(player.current_hand, deck)
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
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def render_hand(player)
    player.hand.render
    puts ''
    PlayerHand.render(player.current_hand)
  end
end

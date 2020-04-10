# frozen_string_literal: true

# Class for game logic
class Game
  attr_reader :players, :deck, :pile

  # TODO: figure out how many players require a third deck
  # TODO: need to reshuffle the discard pile when the deck is empty
  def initialize
    @players = []
    @deck = Deck.new(2)
    @deck.shuffle
    @pile = []
  end

  def build_hand(player)
    PlayerHand.build(player.current_hand, deck)
  end

  def deal
    players.each do |player|
      player.hand(build_hand(player))
    end
  end

  def discard(card)
    pile << card
  end

  # TODO: the following
  # Turns
  # Steals
  # Borrowing
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
      @players << Player.new(name, self)
    end
    deal
    loop do
      players.each(&:take_turn)
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  def render_pile
    if pile.empty?
      puts 'No Pile'
    else
      puts 'Pile:'
      pile.last.render
    end
  end
end

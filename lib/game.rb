# frozen_string_literal: true

require_relative 'prompts'

# Class for game logic
class Game
  include Prompts

  attr_reader :players, :deck, :pile

  # TODO: figure out how many players require a third deck
  # TODO: add constants for maximum number of players
  def initialize
    @players = []
    @deck = Deck.new(2)
    @deck.shuffle
    @pile = Pile.new
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
    pile.discard(card)
  end

  def draw_from_deck
    if deck.empty?
      deck.cards = pile.cards
      deck.shuffle
      pile.cards = []
    end
    deck.draw
  end

  def draw_from_pile
    pile.cards.pop
  end

  def number_of_players
    invalid = false
    num_players = nil
    until valid_number_of_players(num_players)
      invalid_selection_response if invalid
      num_players = number_of_players_prompt
      invalid = true
    end

    num_players
  end

  # TODO: the following
  # Turns
  # Steals
  # Borrowing
  def play # rubocop:disable Metrics/MethodLength
    num_players = number_of_players
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

  def render_hands
    players.each_with_index do |player, idx|
      puts "(#{idx}) #{player.name}'s cards"
      PlayerHand.render(player.current_hand)
      player.hand.render_piles
      puts ''
    end
  end

  def render_pile
    if pile.empty?
      puts 'No Pile'
    else
      puts 'Pile:'
      pile.last.render
    end
  end

  def valid_number_of_players(num)
    num.positive? && num < 5
  end
end

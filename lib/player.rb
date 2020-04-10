# frozen_string_literal: true

require_relative 'prompts'

# Class for player logic
class Player
  include Prompts

  attr_reader :name, :current_hand, :game

  OPTIONS = {
    d: 'Deck',
    p: 'Pile'
  }.freeze

  def initialize(name, game)
    @name = name
    @game = game
    @current_hand = 0
    @score = 0
  end

  def discard
    puts 'You are going to discard'
  end

  # TODO: test with other letters and different cases
  # TODO: this should take a card, hand should be re-rendered
  # TODO: separate business logic from data fetching
  # TODO: pile class & logic, can a card be taken etc
  # TODO: draw should only offer a choice when valid
  def draw(choice)
    return unless Player::OPTIONS.keys.include?(choice)

    hand.cards << if choice == :d
                    game.deck.draw
                  else
                    game.pile.shift
                  end
  end

  def hand(hand = nil)
    @hand ||= hand
  end

  def play
    puts 'You are going to play'
  end

  def play_or_discard(choice)
    if choice == :p
      play
    elsif choice == :d
      discard
    end
  end

  def take_turn
    puts "#{name}'s turn'"
    choice = draw_prompt
    draw(choice)
    hand.render
    choice = play_prompt
    play_or_discard(choice)
  end
end

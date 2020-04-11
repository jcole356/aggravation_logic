# frozen_string_literal: true

require_relative 'prompts'

# Class for player logic
class Player
  include Prompts

  attr_reader :name, :current_hand, :game

  PILE_OPTIONS = {
    d: 'Deck',
    p: 'Pile'
  }.freeze

  def initialize(name, game)
    @name = name
    @game = game
    @current_hand = 0
    @score = 0
  end

  # TODO: remove hardcoded string
  def discard
    idx = card_select_prompt('discard')
    card = hand.select_card(idx)
    discard_response(card)
    game.discard(card)
  end

  # TODO: pile class & logic, can a card be taken etc
  # TODO: draw should only offer a choice when valid
  def draw
    choice = nil

    until Player::PILE_OPTIONS.keys.include?(choice)
      choice = draw_prompt

      hand.cards << if choice == :d
                      game.deck.draw
                    elsif choice == :p
                      game.pile.pop
                    else
                      invalid_selection_response
                      next
                    end
      draw_response(choice)
    end
  end

  def hand(hand = nil)
    @hand ||= hand
  end

  # TODO: choose a set of run by index to play on
  # TODO: remove hardcoded string
  # TODO: validate pile choice
  def play
    loop do
      hand.render # TODO: may not want this every time
      pile_choice = choose_pile_prompt
      break if pile_choice == :q

      piles = {}
      piles.merge!(hand.sets) if hand.sets
      piles.merge!(hand.runs) if hand.runs
      pile = piles[pile_choice]

      if pile.nil?
        invalid_selection_response
        next
      end

      play_card(pile)
    end
  end

  # TODO: need a way to end
  # TODO: game may need a card queue for invalid turns
  # TODO; does not re-render hand
  def play_card(pile)
    loop do
      card_choice = card_select_prompt('play')
      card = hand.select_card(card_choice)
      begin
        pile.play(card)
      rescue StandardError => e
        puts e
        next
      end
      hand.remove_card(card)
      hand.render
    end
  end

  def play_or_discard
    choice = nil

    until Player::PILE_OPTIONS.keys.include?(choice)
      choice = play_prompt

      if choice == :p
        play
        break
      elsif choice == :d
        discard
        break
      else
        invalid_selection_response
      end
    end
  end

  def render_hand
    hand.render
    PlayerHand.render(current_hand)
  end

  def take_turn
    puts "#{name}'s turn"
    render_hand
    game.render_pile
    draw
    hand.render
    play_or_discard
  end
end

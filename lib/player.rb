# frozen_string_literal: true

# rubocop:disable Lint/MissingCopEnableDirective
# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/MethodLength

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

  def swap
    player_choice = swap_player_prompt
    card_choice = swap_card_prompt
    puts "You are going to steal from #{player_choice}, #{card_choice}"
  end

  def can_draw_from_pile?
    !hand.down && game.pile.can_draw_from_pile?
  end

  def discard
    idx = card_discard_prompt
    card = hand.select_card(idx)
    hand.remove_card(card)
    discard_response(card)
    game.discard(card)
  end

  # TODO: draw should only offer a choice when valid
  def draw
    loop do
      choice = draw_prompt

      hand.cards << if choice == :d
                      game.deck.draw
                    elsif choice == :p && can_draw_from_pile?
                      draw_from_pile
                    else
                      invalid_selection_response
                      next
                    end
      draw_response(choice)
      break
    end
  end

  def draw_from_pile
    game.draw_from_pile
  end

  def hand(hand = nil)
    @hand ||= hand
  end

  def play
    piles = {}
    loop do
      hand.render # TODO: may not want this every time
      hand.render_piles
      pile_choice = choose_pile_prompt
      break if pile_choice == :q

      piles.merge!(hand.sets) if hand.sets
      piles.merge!(hand.runs) if hand.runs
      pile = piles[pile_choice]

      if pile.nil?
        invalid_selection_response
        next
      end

      play_card(pile) # TODO: maybe should be play_cards?
    end
    piles.each do |_key, pile|
      pile.abort_play(self) unless pile.complete?
    end
    hand.down = true if piles.values.all?(&:complete?)
  end

  # TODO: game may need a card queue for invalid turns
  # TODO: does not re-render hand
  def play_card(pile)
    loop do
      card_choice = card_play_prompt
      break if card_choice.downcase == 's'

      card = hand.select_card(card_choice.to_i)
      begin
        pile.play(card)
      rescue StandardError => e
        puts e
        next
      end
      hand.remove_card(card)
      hand.render
      hand.render_piles
    end
  end

  def play_or_discard
    choice = nil

    until choice == :d
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
  end

  def take_turn
    puts "#{name}'s turn"
    render_hand
    game.render_hands
    game.render_pile
    draw
    hand.render
    play_or_discard
  end
end

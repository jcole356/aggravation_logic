# frozen_string_literal: true

# Module to handle user prompting logic
module Prompts
  def parse_input(input)
    input.chomp
  end

  def card_discard_prompt
    prompt('Enter the card index of the card you wish to discard').to_i
  end

  def card_play_prompt
    prompt('Enter the card index of the card you wish to play, P to steal from another players hand or S to stop')
  end

  def discard_response(card)
    response('You have discarded the:')
    card.render
  end

  def draw_prompt
    options = Player::PILE_OPTIONS
    prompt("Draw from #{options[:d]} (D) or #{options[:p]} (P)")
      .downcase.to_sym
  end

  def draw_response(choice)
    response("Drawing from the #{Player::PILE_OPTIONS[choice]}")
  end

  def play_prompt
    prompt('Would you like to Play (P) or Discard (D)?').downcase.to_sym
  end

  def choose_pile_prompt
    prompt('Choose a set or run via S# or R#. Enter Q to to stop playing')
      .downcase.to_sym
  end

  def invalid_selection_response
    response('Invalid Selection, please use a valid option')
  end

  def number_of_players_prompt
    prompt('How many players?').to_i
  end

  def swap_card_prompt
    prompt('Which card would you like to steal?').to_i
  end

  def swap_player_prompt
    prompt('Which player would you like to steal from?')
  end

  def prompt(message)
    puts ''
    puts message
    input = parse_input(gets)
    puts ''
    input
  end

  def response(message)
    puts message
    puts ''
  end
end

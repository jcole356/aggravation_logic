# frozen_string_literal: true

# Module to handle user prompting logic
module Prompts
  def parse_input(input)
    input.chomp
  end

  def card_select_prompt(action)
    prompt("Enter the card index of the card you wish to #{action}").to_i
  end

  def discard_response(card)
    response('You have discarded the:')
    card.render
  end

  def draw_prompt
    prompt("Draw from #{Player::OPTIONS[:d]} (D) or #{Player::OPTIONS[:p]} (P)")
      .downcase.to_sym
  end

  def draw_response(choice)
    response("Drawing from the #{Player::OPTIONS[choice]}")
  end

  def play_prompt
    prompt('Would you like to Play (P) or Discard (D)?').downcase.to_sym
  end

  def choose_pile_prompt
    prompt('Choose a set or run via S# or R#. Enter Q to to stop playing')
      .downcase.to_sym
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

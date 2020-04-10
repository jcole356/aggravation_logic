# frozen_string_literal: true

# Module to handle user prompting logic
module Prompts
  def parse_input(input)
    input.chomp.downcase.to_sym
  end

  def draw_prompt
    prompt("Draw from #{Player::OPTIONS[:d]} (D) or #{Player::OPTIONS[:p]} (P)")
  end

  def draw_response
    response("Drawing from the #{Player::OPTIONS[choice]}")
  end

  def play_prompt
    prompt('Would you like to Play (P) or Discard (D)?')
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
  end
end

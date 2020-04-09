# frozen_string_literal: true

# TODO: Create a global require file
require 'game'
require 'deck'
require 'card'
require 'ace'
require 'wild'
require 'hand'
require 'hand_set'
require 'run'

RSpec.describe 'Game.initialize' do
  it 'has 2 decks of cards' do
    game = Game.new

    expect(game.deck.cards.length).to eq(108)
  end
end

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
require 'player'

RSpec.describe 'Game.initialize' do
  it 'has 2 decks of cards' do
    game = Game.new

    expect(game.deck.cards.length).to eq(108)
  end
end

RSpec.describe 'Game::deal' do
  it 'deals the player 11 cards' do
    game = Game.new
    %w[a b c].each { |n| game.players << Player.new(n, game) }
    game.deal

    expect(game.players.length).to eq(3)
    expect(game.players.first.hand.cards.length).to eq(11)
  end
end

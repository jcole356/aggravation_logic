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
  let(:game) { build(:game) }

  it 'has 2 decks of cards' do
    expect(game.deck.cards.length).to eq(108)
  end
end

RSpec.describe 'Game#deal' do
  let(:game) { build(:game) }

  it 'deals the player 11 cards' do
    %w[a b c].each { |n| game.players << Player.new(n, game) }
    game.deal

    expect(game.players.length).to eq(3)
    expect(game.players.first.hand.cards.length).to eq(11)
  end
end

RSpec.describe 'Game#draw_from_deck' do # rubocop:disable Metrics/BlockLength
  let!(:game) { build(:game) }

  context 'when the deck is not empty' do
    it 'takes the top card from the deck' do
      expect { game.draw_from_deck }.to change { game.deck.cards.length }.by(-1)
    end

    it 'does not call shuffle' do
      expect(game.deck).to_not receive(:shuffle)
      expect { game.draw_from_deck }.to change { game.deck.cards.length }.by(-1)
    end
  end

  context 'when the deck is empty' do
    before do
      until game.deck.empty?
        card = game.draw_from_deck
        game.discard(card)
      end
    end

    it 'replaces the deck with the pile and calls shuffle' do
      expect(game.deck.empty?).to eq(true)
      expect(game.pile.empty?).to eq(false)
      expect(game.deck).to receive(:shuffle)
      expect { game.draw_from_deck }
        .to change { game.deck.cards.length }
        .by(game.pile.cards.length - 1)
    end
  end
end

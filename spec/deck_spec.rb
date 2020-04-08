# frozen_string_literal: true

require 'deck'

RSpec.describe 'Deck.initialize' do
  it 'builds the appropriate amount of decks' do
    deck = Deck.new(2)
    expect(deck.cards.length).to eq(108)
  end
end

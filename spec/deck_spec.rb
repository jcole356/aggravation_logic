# frozen_string_literal: true

require 'deck'

RSpec.describe 'Deck.initialize' do
  it 'builds the appropriate amount of decks' do
    deck = Deck.new(2)
    expect(deck.cards.length).to eq(108)
  end
end

RSpec.describe 'Deck::draw' do
  it 'removes the first card from the deck' do
    deck = Deck.new(2)
    last_card = deck.cards.last
    expect { deck.draw }.to(change { deck.cards.length }.by(-1))
    expect(last_card).to eq(deck.cards.last)
  end
end

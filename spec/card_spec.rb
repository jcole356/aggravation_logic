# frozen_string_literal: true

require 'card'

RSpec.describe 'Card.all_cards' do
  it 'returns a full deck of cards' do
    cards = Card.all_cards

    expect(cards.length).to eq(54)
  end
end

RSpec.describe 'Card.wild?' do
  it 'returns true if card is wild' do
    card = Card.new(Card::SUITS[:diamonds], Card::VALUES[:two])

    expect(card.wild?).to eq(true)
  end
end

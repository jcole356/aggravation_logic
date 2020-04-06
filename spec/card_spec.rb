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

RSpec.describe 'Card.rank' do
  it 'returns the cards rank' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:ace])
    card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:jack])
    card3 = Card.new(nil, Card::WILD[:joker])

    expect(card1.rank).to eq([1, 14])
    expect(card2.rank).to eq([11])
    expect(card3.rank).to eq('*')
  end
end

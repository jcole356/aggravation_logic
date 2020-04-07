# frozen_string_literal: true

require 'card'

RSpec.describe 'Card.all_cards' do
  it 'returns a full deck of cards' do
    cards = Card.all_cards

    expect(cards.length).to eq(54)
  end
end

RSpec.describe 'Card::matches' do
  it 'returns true if the cards have the same value' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
    card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])

    expect(card1.matches(card2)).to eq(true)
  end

  it 'returns true if one card is wild' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:two])
    card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])

    expect(card1.matches(card2)).to eq(true)
  end

  it 'returns true if both cards are wild' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:two])
    card2 = Card.new(nil, Card::WILD[:joker])

    expect(card1.matches(card2)).to eq(true)
  end

  it 'returns false if one card does not match' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
    card2 = Card.new(Card::SUITS[:spades], Card::VALUES[:three])

    expect(card1.matches(card2)).to eq(false)
  end
end

RSpec.describe 'Card.wild?' do
  it 'returns true if card is a 2' do
    card = Card.new(Card::SUITS[:diamonds], Card::VALUES[:two])

    expect(card.wild?).to eq(true)
  end

  it 'returns true if card is a joker' do
    card = Card.new(nil, Card::WILD[:joker])

    expect(card.wild?).to eq(true)
  end

  it 'returns false if card is not wild' do
    card = Card.new(Card::SUITS[:hearts], Card::VALUES[:king])

    expect(card.wild?).to eq(false)
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

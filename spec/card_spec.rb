# frozen_string_literal: true

require 'card'
require 'wild'

RSpec.describe 'Card.all_cards' do
  it 'returns a full deck of cards' do
    cards = Card.all_cards

    expect(cards.length).to eq(54)
  end
end

RSpec.describe 'Card::matches?' do
  it 'returns true if the cards have the same value' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
    card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])

    expect(card1.matches?(card2)).to eq(true)
  end

  it 'returns true if one card is wild', focus: true do
    card1 = Wild.new(Card::SUITS[:diamonds], Card::VALUES[:two])
    card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])

    expect(card1.matches?(card2)).to eq(true)
  end

  it 'returns true if both cards are wild' do
    card1 = Wild.new(Card::SUITS[:diamonds], Card::VALUES[:two])
    card2 = Card.new(nil, Card::WILD[:joker])

    expect(card1.matches?(card2)).to eq(true)
  end

  it 'returns false if one card does not match' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
    card2 = Card.new(Card::SUITS[:spades], Card::VALUES[:three])

    expect(card1.matches?(card2)).to eq(false)
  end
end

RSpec.describe 'Card::next?' do # rubocop:disable Metrics/BlockLength
  context 'when the card is the same suit' do
    xit 'returns true if the card is the next in the sequence' do
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
      card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:eight])

      expect(card2.next?(card1)).to eq(true)
    end
  end

  context 'when the previous card is wild' do
    xit 'returns true if the card is the next in the sequence' do
      card1 = Wild.new(Card::SUITS[:diamonds], Card::VALUES[:two])
      card1.set_current_value(Card::VALUES[:seven])
      card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:eight])

      expect(card2.next?(card1)).to eq(true)
    end
  end

  context 'when the card is wild' do
    xit 'returns true' do
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
      card2 = Wild.new(Card::SUITS[:diamonds], Card::VALUES[:two])

      expect(card2.next?(card1)).to eq(true)
    end
  end

  context 'when the card is not the same suit' do
    xit 'returns false if the card is the next in the sequence' do
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
      card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:eight])

      expect(card2.next?(card1)).to eq(false)
    end
  end
end

RSpec.describe 'Card::rank' do
  it 'returns the cards possible ranks' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:ace])
    card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:jack])
    card3 = Wild.new(nil, Card::WILD[:joker])

    expect(card1.ranks).to eq([1, Card.values.length + 1])
    expect(card2.ranks).to eq([11])
    expect(card3.ranks).to eq((1..Card.values.length + 1).to_a)
  end
end

RSpec.describe 'Card::same_suit?' do
  it 'returns true if the cards have the same suit' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:ace])
    card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:jack])

    expect(card1.same_suit?(card2)).to eq(true)
  end
end

RSpec.describe 'Card::wild?' do
  it 'returns true if card is a 2' do
    card = Wild.new(Card::SUITS[:diamonds], Card::VALUES[:two])

    expect(card.wild?).to eq(true)
  end

  it 'returns true if card is a joker' do
    card = Wild.new(nil, Card::WILD[:joker])

    expect(card.wild?).to eq(true)
  end

  it 'returns false if card is not wild' do
    card = Card.new(Card::SUITS[:hearts], Card::VALUES[:king])

    expect(card.wild?).to eq(false)
  end
end

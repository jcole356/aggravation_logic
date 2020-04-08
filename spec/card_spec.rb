# frozen_string_literal: true

require 'card'
require 'ace'
require 'wild'

RSpec.describe 'Card.all_cards' do
  cards = Card.all_cards

  it 'returns a full deck of cards' do
    expect(cards.length).to eq(54)
  end

  it 'returns 2 jokers' do
    expect(cards.filter do |card|
      card.value == Card::WILD[:joker]
    end.length).to eq(2)
  end

  it 'returns 6 wild cards' do
    expect(cards.filter { |card| card.class == Wild }.length).to eq(6)
  end

  it 'returns 4 twos' do
    expect(cards.filter do |card|
      card.value == Card::WILD[:two]
    end.length).to eq(4)
  end

  it 'returns 4 aces' do
    expect(cards.filter { |card| card.class == Ace }.length).to eq(4)
  end
end

RSpec.describe 'Card::matches?' do
  it 'returns true if the cards have the same value' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
    card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])

    expect(card1.matches?(card2)).to eq(true)
  end

  it 'returns true if one card is wild' do
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
    it 'returns true if the card is the next in the sequence' do
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
      card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:eight])

      expect(card2.next?(card1)).to eq(true)
    end
  end

  context 'when the previous card is wild' do
    it 'returns true if the card is the next in the sequence' do
      card1 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])
      card1.current_value(Card::VALUES[:seven])
      card1.current_suit(Card::SUITS[:diamonds])
      card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:eight])

      expect(card2.next?(card1)).to eq(true)
    end
  end

  context 'when the card is wild' do
    it 'returns true' do
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
      card2 = Wild.new(nil, Card::WILD[:joker])
      card2.current_value(Card::VALUES[:eight])
      card2.current_suit(Card::SUITS[:diamonds])

      expect(card2.next?(card1)).to eq(true)
    end
  end

  context 'when the card is not the same suit' do
    it 'returns false' do
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
      card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:eight])

      expect(card2.next?(card1)).to eq(false)
    end
  end
end

RSpec.describe 'Card::points' do
  it 'returns the point value of the card' do
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:seven])
    card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:eight])
    card3 = Wild.new(nil, Card::VALUES[:two])
    card4 = Ace.new(Card::SUITS[:diamonds])

    expect(card1.points).to eq(5)
    expect(card2.points).to eq(10)
    expect(card3.points).to eq(20)
    expect(card4.points).to eq(15)
  end
end

RSpec.describe 'Card::rank' do
  it 'returns the rank of a standard card' do
    card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:jack])

    expect(card2.rank).to eq(11)
  end

  it 'returns the current rank of a wild card' do
    card2 = Wild.new(nil, Card::WILD[:joker])
    card2.current_value(Card::VALUES[:three])

    expect(card2.rank).to eq(3)
  end

  it 'returns the correct rank of an ace low' do
    card = Ace.new(Card::SUITS[:diamonds])
    card.current_value(Card::VALUES[:ace])

    expect(card.rank).to eq(1)
  end

  it 'returns the correct rank of an ace high' do
    card = Ace.new(Card::SUITS[:diamonds])
    card.current_value(Card::SPECIAL[:ace_high])

    expect(card.rank).to eq(14)
  end
end

RSpec.describe 'Card::same_suit?' do
  it 'returns true if the cards have the same suit' do
    card1 = Ace.new(Card::SUITS[:diamonds])
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

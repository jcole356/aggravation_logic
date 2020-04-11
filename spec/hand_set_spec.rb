# frozen_string_literal: true

require 'card'
require 'wild'
require 'hand_set'

RSpec.describe 'Hand::valid_move?' do
  it 'returns true if the set is empty' do
    set = HandSet.new(3)
    card = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])

    expect(set.valid_move?(card)).to eq(true)
  end

  it 'returns true if the card matches the set' do
    set = HandSet.new(3)
    set.value = Card::VALUES[:five]
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
    set.cards << card1
    card2 = Card.new(Card::SUITS[:hears], Card::VALUES[:five])

    expect(set.valid_move?(card2)).to eq(true)
  end

  it 'returns false if the card does not match set' do
    set = HandSet.new(3)
    set.value = Card::VALUES[:five]
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
    set.cards << card1
    card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:three])

    expect(set.valid_move?(card2)).to eq(false)
  end

  context 'when the card is wild' do
    it 'returns true if there are at least two natural cards' do
      set = HandSet.new(3)
      set.value = Card::VALUES[:five]
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
      card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])
      set.cards << card1
      set.cards << card2
      card3 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])

      expect(set.valid_move?(card3)).to eq(true)
    end

    it 'returns false if are not at least two natural cards' do
      set = HandSet.new(3)
      set.value = Card::VALUES[:five]
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
      set.cards << card1
      card2 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])

      expect(set.valid_move?(card2)).to eq(false)
    end
  end

  context 'when the previous card is wild' do
    it 'returns true if the card matches a natural card' do
      set = HandSet.new(3)
      set.value = Card::VALUES[:five]
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
      card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])
      set.cards << card1
      set.cards << card2
      card3 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])

      expect(set.valid_move?(card3)).to eq(true)
    end

    it 'returns false if it does not match a natural card' do
      set = HandSet.new(3)
      set.value = Card::VALUES[:five]
      card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
      set.cards << card1
      card2 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])

      expect(set.valid_move?(card2)).to eq(false)
    end
  end
end

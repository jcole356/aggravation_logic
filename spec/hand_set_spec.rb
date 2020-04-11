# frozen_string_literal: true

require 'card'
require 'hand_set'

RSpec.describe 'Hand::valid_move?' do
  it 'returns true if the set is empty' do
    set = HandSet.new(3)
    card = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])

    expect(set.valid_move?(card)).to eq(true)
  end

  it 'returns true if the card matches the set' do
    set = HandSet.new(3)
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
    set.cards << card1
    card2 = Card.new(Card::SUITS[:hears], Card::VALUES[:five])

    expect(set.valid_move?(card2)).to eq(true)
  end

  it 'returns false if the card does not match set' do
    set = HandSet.new(3)
    card1 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])
    set.cards << card1
    card2 = Card.new(Card::SUITS[:diamonds], Card::VALUES[:three])

    expect(set.valid_move?(card2)).to eq(false)
  end
end

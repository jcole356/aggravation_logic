# frozen_string_literal: true

require 'card'
require 'hand_set'

RSpec.describe 'Hand::valid_move?' do
  it 'returns true if the set is empty' do
    set = HandSet.new(3)
    card = Card.new(Card::SUITS[:diamonds], Card::VALUES[:five])

    expect(set.valid_move?(card)).to eq(true)
  end
end

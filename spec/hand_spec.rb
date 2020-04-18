# frozen_string_literal: true

RSpec.describe 'Hand.initialize' do
  cards = Deck.new(1).shuffle

  it 'has the correct number of sets' do
    sets = []
    3.times { sets << HandSet.new(3) }

    hand = PlayerHand.new(cards.take(11), sets)
    expect(hand.sets.length).to eq(3)
  end

  it 'has the correct number of runs' do
    runs = []
    2.times { runs << Run.new(4, true) }

    hand = PlayerHand.new(cards.take(11), nil, runs)
    expect(hand.runs.length).to eq(2)
    expect(hand.runs.first.same_suit).to eq(true)
  end
end

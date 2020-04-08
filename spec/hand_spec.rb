# frozen_string_literal: true

require 'hand'
require 'hand_set'
require 'run'

RSpec.describe 'Hand.initialize' do
  it 'has the correct number of sets' do
    sets = []
    3.times { sets << HandSet.new(3) }

    hand = PlayerHand.new(sets)
    expect(hand.sets.length).to eq(3)
  end

  it 'has the correct number of runs' do
    runs = []
    2.times { runs << Run.new(4, true) }

    hand = PlayerHand.new(runs)
    expect(hand.runs.length).to eq(2)
    expect(hand.runs.first.same_suit).to eq(true)
  end
end

# frozen_string_literal: true

RSpec.describe 'Hand::valid_move?' do
  let(:card1) { build(:card) }

  it 'returns true if the set is empty' do
    set = HandSet.new(3)

    expect(set.valid_move?(card1)).to eq(true)
  end

  it 'returns true if the card matches the set' do
    set = HandSet.new(3)
    set.play(card1)
    card2 = build(:card, suit: Card::SUITS[:hearts])

    expect(set.valid_move?(card2)).to eq(true)
  end

  it 'returns false if the card does not match set' do
    set = HandSet.new(3)
    set.play(card1)
    card2 = build(:card, value: Card::VALUES[:three])

    expect(set.valid_move?(card2)).to eq(false)
  end

  context 'when the card is wild' do
    it 'returns true if there are at least two natural cards' do
      set = HandSet.new(3)
      card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])
      set.play(card1)
      set.play(card2)
      card3 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])

      expect(set.valid_move?(card3)).to eq(true)
    end

    it 'returns false if are not at least two natural cards' do
      set = HandSet.new(3)
      set.play(card1)
      card2 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])

      expect(set.valid_move?(card2)).to eq(false)
    end
  end

  context 'when the previous card is wild' do
    it 'returns true if the card matches a natural card' do
      set = HandSet.new(3)
      card2 = Card.new(Card::SUITS[:hearts], Card::VALUES[:five])
      set.play(card1)
      set.play(card2)
      card3 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])

      expect(set.valid_move?(card3)).to eq(true)
    end

    it 'returns false if it does not match a natural card' do
      set = HandSet.new(3)
      set.play(card1)
      card2 = Wild.new(Card::SUITS[:hearts], Card::VALUES[:two])

      expect(set.valid_move?(card2)).to eq(false)
    end
  end
end

# TODO: going to need lots of factories to test all these things
RSpec.describe 'Hand::abort_play' do
  let(:card1) { build(:card) }
  let(:card2) { build(:card, suit: Card::SUITS[:hearts]) }
  set = HandSet.new(3)
  game = Game.new
  player = Player.new('Kimie', game)

  before(:each) do
    set.play(card1)
    set.play(card2)
    game.players << player
    game.deal
    set.abort_play(player)
  end

  it 'returns cards to the player if the hand is incomplete' do
    expect([card1, card2].all? { |c| player.hand.cards.include?(c) }).to eq(true)
  end

  it 'resets the value of the set' do
    expect(set.value).to eq(nil)
  end
end

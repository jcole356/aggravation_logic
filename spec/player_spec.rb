# frozen_string_literal: true

RSpec.describe 'Player::swap_cards' do
  let(:player1) { build(:player) }
  let(:player2) { build(:player, name: 'Kimie') }

  it 'swaps cards with another player' do
    card1 = build(:card)
    card2 = build(:wild)
    hand = build(:player_hand, cards: [card1, card2])

    expect(player1.name).to eq('Sai Chi Cockatiel')
    expect(player2.name).to eq('Kimie')
    expect(hand.cards.length).to eq(2)
  end
end

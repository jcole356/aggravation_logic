# frozen_string_literal: true

# TODO: add tests for swap
RSpec.describe 'Player::swap' do # rubocop:disable Metrics/BlockLength
  let(:game) { build(:game) }

  let(:player1) { build(:player, game: game) }
  let(:player2) { build(:player, name: 'Kimie', game: game) }

  let(:set1) { build(:hand_set, num_cards: 3) }
  let(:set2) { build(:hand_set, num_cards: 3) }

  let(:card1) { build(:card, suit: Card::SUITS[:clubs]) }
  let(:card2) { build(:card, suit: Card::SUITS[:hearts]) }
  let(:card3) { build(:card, suit: Card::SUITS[:spades]) }
  let(:ace1) { build(:ace) }

  let(:card4) do
    build(:card, suit: Card::SUITS[:spades], value: Card::VALUES[:jack])
  end
  let(:ace2) { build(:ace) }
  let(:ace3) { build(:ace, suit: Card::SUITS[:clubs]) }
  let(:wild1) { build(:wild, suit: Card::SUITS[:clubs]) }
  let(:wild2) { build(:wild, suit: Card::SUITS[:clubs]) }

  before(:each) do
    game.players << player1
    game.players << player2
    hand1_cards = [card1, card2, card3]
    hand2_cards = [card4]
    wild1.current_value(card1.value)
    wild2.current_value(card1.value)
    set2_cards = [ace1, ace2, wild1, wild2]
    set2.cards.concat(set2_cards)
    hand1 = build(:player_hand, cards: hand1_cards, sets: [set1])
    hand2 = build(:player_hand, cards: hand2_cards, sets: [set2])
    player1.hand(hand1)
    player2.hand(hand2)
    hand2.down = true

    expect_any_instance_of(Prompts).to receive(:swap_player_prompt).and_return(1)
    expect_any_instance_of(Prompts).to receive(:swap_pile_prompt).and_return(0)
    expect_any_instance_of(Prompts).to receive(:swap_card_prompt).and_return(2)
    expect_any_instance_of(Prompts).to receive(:card_swap_prompt).and_return(2)
  end

  it 'removes a card from the first players hand' do
    expect do
      expect(player1.swap).to eq(true)
    end.to change { player1.hand.cards.count }.by(-1)
  end
end

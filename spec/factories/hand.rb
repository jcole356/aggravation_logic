# frozen_string_literal: true

FactoryBot.define do
  factory :player_hand do
    initialize_with { new(cards) }
  end
end

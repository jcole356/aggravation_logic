# frozen_string_literal: true

FactoryBot.define do
  factory :hand_set do
    initialize_with { new(num_cards) }
  end
end

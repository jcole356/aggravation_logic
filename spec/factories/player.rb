# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    name { 'Sai Chi Cockatiel' }
    game { build(:game) }

    initialize_with { new(name, game) }
  end
end

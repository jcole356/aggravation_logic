# frozen_string_literal: true

require 'card'

FactoryBot.define do
  factory :card do
    suit { Card::SUITS[:diamonds] }
    value { Card::VALUES[:five] }

    initialize_with { new(suit, value) }
  end
end

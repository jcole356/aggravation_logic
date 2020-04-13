# frozen_string_literal: true

require_relative 'deck'
require_relative 'card'
require_relative 'ace'
require_relative 'wild'
require_relative 'hand'
require_relative 'hand_set'
require_relative 'run'
require_relative 'player'
require_relative 'pile'
require_relative 'game'

game = Game.new
game.play

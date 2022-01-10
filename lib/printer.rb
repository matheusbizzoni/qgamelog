# frozen_string_literal: true

require_relative 'game'

require 'byebug'
require 'json'

# Printer module: prints the results of games
module Printer
  class Error < StandardError; end

  def print_game(game)
    hash = {
      game.name => {
        'total_kills' => game.total_kills,
        'players' => game.players,
        'kills' => Hash[game.players_hash.sort_by { |_k, v| v }.reverse],
        'kills_by_means' => Hash[game.kills_by_means.sort_by { |_k, v| v }.reverse]
      }
    }
    puts JSON.pretty_generate(hash)
  end
end

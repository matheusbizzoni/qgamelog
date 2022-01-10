# frozen_string_literal: true

require_relative 'game'
require_relative 'printer'

# Qgamelog Class: application starter
class Qgamelog
  class Error < StandardError; end
  include Printer
  FILE_PATH = File.join(File.dirname(__FILE__), 'qgames.log')
  INIT_GAME_REGEX = /^.+\sInitGame:\s/.freeze
  KILLED_REGEX = /.+:\s(.+)\skilled\s(.+)by\s(.+)$/.freeze
  NON_KILL_REGEX = /^.+\sItem:|ClientBegin:|ClientUserinfoChanged:|ClientConnect:\s/.freeze

  def initialize
    @count_games = 0
    @game = nil
    run_parser
  end

  def run_parser
    read_file
  rescue StandardError => e
    puts e
  end

  def read_file
    File.readlines(FILE_PATH).each do |line|
      next if line.match(NON_KILL_REGEX)

      if line.match(INIT_GAME_REGEX)
        print_and_start_new_game
        next
      end

      if @game && match = line.match(KILLED_REGEX)
        killer, killed, mean = match.captures
        @game.add_kill(killer.strip, killed.strip, mean.strip)
      end
    end
    print_game(@game) if @game
  end

  def print_and_start_new_game
    print_game(@game) unless @game.nil?
    @count_games += 1
    @game = Game.new(@count_games)
  end

  Qgamelog.new
end

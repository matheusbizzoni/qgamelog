# frozen_string_literal: true

# Game class.
class Game
  class Error < StandardError; end

  DEFAULT_PLAYER = '<world>'

  attr_reader :number, :players, :players_hash, :total_kills, :kills_by_means

  def initialize(number)
    @number = number
    @players = []
    @players_hash = Hash.new(0)
    @total_kills = 0
    @kills_by_means = Hash.new(0)
  end

  def add_kill(killer, killed, mean)
    return if killer.nil? || killed.nil? || mean.nil?

    add_total_kills
    add_mean(mean)
    add_killer_and_killed(killer, killed)
    count_kill(killer, killed)
  end

  private

  def add_total_kills
    @total_kills += 1
  end

  def add_mean(mean)
    @kills_by_means[mean] += 1
  end

  def add_killer_and_killed(killer, killed)
    @players << killer unless @players.include?(killer) || killer == DEFAULT_PLAYER
    @players << killed unless @players.include?(killed)
  end

  def count_kill(killer, killed)
    if killer == DEFAULT_PLAYER
      @players_hash[killed] -= 1
    else
      @players_hash[killer] += 1
    end
  end
end

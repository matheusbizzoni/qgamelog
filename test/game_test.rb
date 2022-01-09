# frozen_string_literal: true

require 'test_helper'

describe 'GameTest' do
  before do
    @game = ::Game.new(1)
  end

  describe 'add_kill' do
    describe 'when normal player kills' do
      before(:all) { @game.add_kill('Isgalamido', 'Mocinha', 'MOD_ROCKET_SPLASH') }

      it 'adds to players list' do
        _(@game.players).must_equal %w[Isgalamido Mocinha]
      end

      it 'adds MOD_ROCKET_SPLASH as a mean' do
        _(@game.kills_by_means['MOD_ROCKET_SPLASH']).must_equal 1
      end

      it 'Isgalamido kills must be equals 1' do
        _(@game.players_hash['Isgalamido']).must_equal 1
      end

      it 'counts total_kills' do
        _(@game.total_kills).must_equal 1
      end
    end

    describe 'when default player kills' do
      before(:all) { @game.add_kill('<world>', 'Dono da Bola', 'MOD_ROCKET_SPLASH') }

      it 'adds to players list' do
        _(@game.players).must_equal ['Dono da Bola']
      end

      it 'adds MOD_ROCKET_SPLASH as a mean' do
        _(@game.kills_by_means['MOD_ROCKET_SPLASH']).must_equal 1
      end

      it '<world> kills must not be on players_hash' do
        _(@game.players_hash).must_equal({ 'Dono da Bola' => -1 })
      end

      it 'counts total_kills' do
        _(@game.total_kills).must_equal 1
      end
    end

    describe 'when more than one kills' do
      before(:all) do
        @game.add_kill('Isgalamido', 'Mocinha', 'MOD_ROCKET_SPLASH')
        @game.add_kill('Isgalamido', 'Dono da Bola', 'MOD_ROCKET_SPLASH')
        @game.add_kill('Mocinha', 'Dono da Bola', 'MOD_ROCKET_SPLASH')
        @game.add_kill('<world>', 'Isgalamido', 'MOD_TRIGGER_HURT')
      end

      it 'adds to players list' do
        _(@game.players).must_equal ['Isgalamido', 'Mocinha', 'Dono da Bola']
      end

      it 'adds means' do
        _(@game.kills_by_means).must_equal({ 'MOD_ROCKET_SPLASH' => 3, 'MOD_TRIGGER_HURT' => 1 })
      end

      it '<world> kills must not be on players_hash' do
        _(@game.players_hash).must_equal({ 'Isgalamido' => 1, 'Mocinha' => 1 })
      end

      it 'counts total_kills' do
        _(@game.total_kills).must_equal 4
      end
    end
  end
end

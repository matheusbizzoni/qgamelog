# frozen_string_literal: true

require 'test_helper'

class QgamelogTest < Minitest::Test
  describe 'testing regex expressions' do
    it 'expect to match INIT_GAME_REGEX' do
      assert_match(Qgamelog::INIT_GAME_REGEX, '1:47 InitGame: \sv_floodProt')
    end

    it 'expect ClientConnect line to match NON_KILL_REGEX' do
      assert_match(Qgamelog::NON_KILL_REGEX, '1:47 ClientConnect: 2')
    end

    it 'expect ClientUserinfoChanged line to match NON_KILL_REGEX' do
      assert_match(Qgamelog::NON_KILL_REGEX, '1:47 ClientUserinfoChanged: 3 n\Isgalamido\t\0')
    end

    it 'expect Item line to match NON_KILL_REGEX' do
      assert_match(Qgamelog::NON_KILL_REGEX, '1:48 Item: 4 weapon_rocketlauncher')
    end

    it 'expect kill users line to match KILLED_REGEX' do
      assert_match(Qgamelog::KILLED_REGEX, '2:22 Kill: 3 2 10: Isgalamido killed Dono da Bola by MOD_RAILGUN')
    end

    it 'expect <world> kill line to match KILLED_REGEX' do
      assert_match(Qgamelog::KILLED_REGEX, '2:04 Kill: 1022 3 19: <world> killed Isgalamido by MOD_FALLING')
    end

    it 'expect KILLED_REGEX captures to match <world> killer' do
      match = '2:04 Kill: 1022 3 19: <world> killed Isgalamido by MOD_FALLING'.match(Qgamelog::KILLED_REGEX)
      _(match.captures).must_equal ["<world>", "Isgalamido ", "MOD_FALLING"]
    end

    it 'expect KILLED_REGEX captures to match user killer' do
      match = '2:22 Kill: 3 2 10: Isgalamido killed Dono da Bola by MOD_RAILGUN'.match(Qgamelog::KILLED_REGEX)
      _(match.captures).must_equal ["Isgalamido", "Dono da Bola ", "MOD_RAILGUN"]
    end
  end
end

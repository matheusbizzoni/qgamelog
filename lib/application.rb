# frozen_string_literal: true

require_relative 'qgamelog'
# Application Class: application starter
class Application
  class Error < StandardError; end
  Qgamelog.new
end

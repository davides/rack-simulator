require "rack/simulator/version"
require "rack/simulator/logging"
require "rack/simulator/recording"
require "rack/simulator/recording_input"
require "rack/simulator/recording_response"

module Rack
  module Simulator
    def self.log
      @@logger ||= ::Logger.new(STDOUT)
    end
  end
end
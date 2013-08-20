require 'logger'

module Probe
  class Configuration

    attr_accessor :api_key
    attr_accessor :endpoint
    attr_accessor :debug
    attr_accessor :logger
    attr_accessor :environment
    attr_accessor :use_ssl

    def initialize
      self.logger = Logger.new($stdout)
      self.logger.level = Logger::DEBUG
    end

    def should_notify?
      true
    end

  end
end
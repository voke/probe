require 'logger'

module Probe
  class Configuration

    attr_accessor :api_key
    attr_accessor :endpoint
    attr_accessor :debug
    attr_accessor :logger
    attr_accessor :use_ssl
    attr_accessor :enabled

    def initialize
      self.logger = Logger.new($stdout)
      self.logger.level = Logger::DEBUG
      self.enabled = ENV['PROBE_NOTIFY'] == '1'
    end

    def enabled?
      self.enabled == true
    end

    def disabled?
      !enabled?
    end

    def enable
      self.enabled = true
    end

    def disable
      self.enabled = false
    end

  end
end
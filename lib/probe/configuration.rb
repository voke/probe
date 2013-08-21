require 'logger'

module Probe
  class Configuration

    attr_accessor :api_key
    attr_accessor :endpoint
    attr_accessor :debug
    attr_accessor :logger
    attr_accessor :environment
    attr_accessor :use_ssl
    attr_accessor :notify_environments

    def initialize
      self.logger = Logger.new($stdout)
      self.logger.level = Logger::DEBUG
      self.notify_environments = %w(production)
    end

    def should_notify?
      notify_environments.include?(environment)
    end

  end
end
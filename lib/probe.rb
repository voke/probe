require 'forwardable'
require 'probe/version'
require 'probe/configuration'
require 'probe/notification'

require "probe/railtie" if defined?(Rails::Railtie)

module Probe

  LOG_PREFIX = "-- [Probe] "

  class << self

    extend Forwardable
    def_delegators :configuration, :enable, :disable, :enabled?

    def configure(hash = {})
      hash.each do |key, value|
        configuration.public_send("#{key}=", value)
      end
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def signal
      enable
      yield
    ensure
      disable
    end

    def notify(category, action, next_run = nil, options = {})
      yield if block_given?
      options[:next_run] = next_run
      Notification.new(category, action, configuration, options).deliver
    end

    def log(message)
      configuration.logger.info("#{LOG_PREFIX}#{message}")
    end

    def debug(message)
      configuration.logger.debug("#{LOG_PREFIX}#{message}")
    end

    def warn(message)
      configuration.logger.warn("#{LOG_PREFIX}#{message}")
    end

  end

end

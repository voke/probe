require 'probe/version'
require 'probe/configuration'
require 'probe/notification'

module Probe

  LOG_PREFIX = "-- [Probe] "

  class << self

    def configure(hash = {})
      hash.each do |key, value|
        configuration.public_send("#{key}=", value)
      end
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def notify(category, action, options = {})
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

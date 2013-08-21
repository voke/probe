module Probe
  class Railtie < Rails::Railtie

    config.before_initialize do

      Probe.configure do |config|
        config.logger = Rails.logger
        config.environment = Rails.env.to_s
      end

    end

  end
end
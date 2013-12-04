module Probe
  class Railtie < Rails::Railtie

    config.before_initialize do

      Probe.configure do |config|
        config.logger = Rails.logger
      end

    end

  end
end
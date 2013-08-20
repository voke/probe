require 'httparty'
require 'json'

module Probe
  class Notification

    include HTTParty

    NOTIFIER_NAME = 'Probe Notifier'
    NOTIFIER_VERSION = Probe::VERSION

    default_timeout 5
    headers  "Content-Type" => "application/json"

    attr_accessor :category, :action, :config, :options

    def initialize(category, action, config, options = {})
      self.category = category
      self.action = action
      self.config = config
      self.options = options
    end

    def deliver

      return unless @config.should_notify?

      if @config.api_key.nil?
        Probe.warn("No API key configured, couldn't notify")
        return
      end

      if @config.endpoint.nil?
        Probe.warn("No endpoint configured, couldn't notify")
        return
      end

      endpoint = (config.use_ssl ? "https://" : "http://") + config.endpoint
      Probe.log("Notifying #{endpoint} of [#{category}, #{action}] from api_key #{config.api_key}")

      Notification.deliver_payload(endpoint, @config.api_key, payload)

    end

    def payload
      {
        notifier: {
          name: NOTIFIER_NAME,
          version: NOTIFIER_VERSION
        },
        events: [as_json]
      }
    end

    def as_json
      { category: category, action: action }
    end

    class << self

      def deliver_payload(endpoint, key, payload)
        begin
          payload_string = JSON.dump(payload)
          options = { body: payload_string, headers: { 'X-API-KEY' => key } }
          response = post(endpoint, options)
          Probe.debug("Notification to #{endpoint} finished, response was #{response.code}, payload was #{payload_string}")
        rescue StandardError => e
          Probe.warn("Notification to #{endpoint} failed, #{e.inspect}")
        end
      end

    end

  end
end
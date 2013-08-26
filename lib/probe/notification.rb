require 'httparty'
require 'json'

module Probe
  class Notification

    include HTTParty

    NOTIFIER_NAME = 'Probe Notifier'
    NOTIFIER_VERSION = Probe::VERSION
    DEFAULT_OFFSET = 600
    DEFAULT_NEXT_RUN = 86400

    default_timeout 5
    headers  "Content-Type" => "application/json"

    attr_accessor :category, :action, :config, :next_run, :offset, :last_run

    def initialize(category, action, config, options = {})
      self.category = category
      self.action = action.is_a?(Array) ? action.join('/') : action
      self.config = config
      self.next_run = options[:next_run] ? options[:next_run].to_i : default_next_run
      self.offset = options[:offset] || DEFAULT_OFFSET
      self.last_run = Time.now.to_i
    end

    def default_next_run
      Time.now.to_i + DEFAULT_NEXT_RUN
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
      Probe.log("Notifying #{endpoint} of #{category}, #{action} from api_key #{config.api_key}")

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

    def next_run_with_offset
      next_run + offset
    end

    def as_json
      {
        category: category,
        action: action,
        last_run: last_run,
        next_run: next_run_with_offset,
        environment: config.environment
      }
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
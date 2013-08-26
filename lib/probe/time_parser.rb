require 'chronic'

module Probe
  class TimeParser

    TOMORROW = 86400

    def self.parse(value)
      case value
      when Symbol then parse_symbol(value)
      when String then parse_string(value)
      else
        value
      end
    end

    def self.parse_string(value)
      if result = Chronic.parse(value)
        result.to_i
      end
    end

    def self.parse_symbol(value)
      if value == :tomorrow
        Time.now + TOMORROW
      else
        raise 'Not a valid argument'
      end
    end

  end
end


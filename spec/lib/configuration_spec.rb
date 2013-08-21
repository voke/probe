require 'spec_helper'

describe Probe::Configuration do

  describe '#should_notify?' do

    before do
      @config = Probe::Configuration.new
      @config.notify_environments = %w(foo bar)
    end

    it 'returns true if notify_environments include environment' do
      @config.environment = 'foo'
      @config.should_notify?.must_equal true
    end

    it 'returns false otherwise' do
      @config.environment = 'lorem'
      @config.should_notify?.must_equal false
    end

  end

end
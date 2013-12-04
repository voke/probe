require 'spec_helper'

describe Probe do

  describe '.configuration' do

    it 'returns instance of configuration' do
      Probe.configuration.must_be_instance_of Probe::Configuration
    end

  end

  describe '.configure' do

    it 'yields configuration object when block given' do
      Probe.configure do |config|
        config.must_equal Probe.configuration
      end
    end

    it 'supports Hash as argument' do
      Probe.configure(api_key: '123456')
      Probe.configuration.api_key.must_equal '123456'
    end

  end

  describe '.notify' do

    it 'supports block' do

      dummy = stub(:foo)
      dummy.expects(:hello)

      Probe.notify(:foo, :bar) do
        dummy.hello
      end

    end

  end

end
require 'spec_helper'

describe Probe::Configuration do

  describe '#initialize' do

    it 'defaults enabled to PROBE_NOTIFY' do
      ENV['PROBE_NOTIFY'] = '1'
      config = Probe::Configuration.new
      config.enabled.must_equal true
    end

  end

  describe '.enable' do

    it 'sets @enable to true' do
      Probe.enable
      Probe.enabled?.must_equal true
    end

  end

  describe '.disable' do

    it 'sets @enable to false' do
      Probe.disable
      Probe.enabled?.must_equal false
    end

  end


end
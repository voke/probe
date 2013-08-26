require 'spec_helper'

describe Probe::TimeParser do

  describe '#parse' do

    it 'parses using chronic when string' do
      Chornic.expects(:parse).with('1 day from now')
      Probe::TimeParser.parse('1 day from now')
    end

    it 'returns integer for integer' do
      Probe::TimeParser.parse(1377268759).must_equal 1377268759
    end

    it 'returns nil for nil' do
      Probe::TimeParser.parse(nil).must_equal nil
    end

    it 'supports :tomorrow symbol' do
      Probe::TimeParser.parse(:tormorrow).must_equal (Time.now + 60*60*24).to_i
    end

  end

end
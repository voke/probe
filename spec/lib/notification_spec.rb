require 'spec_helper'

describe Probe::Notification do

  describe '#initialize' do

    it 'supports Array as action' do
      notification = Probe::Notification.new(nil, ['hello','world'], nil)
      notification.action.must_equal 'hello/world'
    end

    it 'casts next_run to integer if given' do
      notification = Probe::Notification.new(nil, nil, Time.now)
      notification.next_run.must_be_instance_of(Fixnum)
    end

  end

  describe '#deliver' do

    before do
      Probe.configure do |config|
        config.api_key = 'foo'
        config.endpoint = 'example.com/api/'
      end
    end

    it 'supports force option' do
      Probe::Notification.expects(:deliver_payload)
      Probe.disable
      Probe.notify('foo', 'bar', nil, force: true)
    end

  end

  describe '#as_json' do
  end

end
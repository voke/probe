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

end
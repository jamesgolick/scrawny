require File.dirname(__FILE__)+'/test_helper'

include Scrawny

Expectations do
  expect QueueItem.to.receive(:find).with(:first, :order => 'created_at ASC').returns(stub_everything) do
    QueueItem.pop
  end
  
  expect mock.to.receive(:destroy) do |qi|
    QueueItem.stubs(:find).returns(qi)
    QueueItem.pop
  end
end

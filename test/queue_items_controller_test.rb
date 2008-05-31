require File.dirname(__FILE__)+'/test_helper'

include Scrawny

Expectations do
  expect QueueItem.to.receive(:create).with(:value => 'mockvalue') do
    c = QueueItemsController.new({})
    c.stubs(:params).returns(:queue_item => {:value => 'mockvalue'})
    c.call(:create)
  end
  
  expect QueueItem.to.receive(:pop) do
    c = QueueItemsController.new({})
    c.call(:delete_collection)
  end
end

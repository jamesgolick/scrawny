require File.dirname(__FILE__)+'/test_helper'

include Scrawny

Expectations do
  expect QueueItem.to.receive(:create).with(:value => 'mockvalue') do
    c = QueueItemsController.new({})
    c.stubs(:params).returns(:queue_item => {:value => 'mockvalue'})
    c.call(:create)
  end
  
  expect '/queue_items/5' do
    QueueItem.stubs(:create).returns(stub(:id => 5))
    c = QueueItemsController.new({})
    c.stubs(:params).returns({})
    c.call(:create)[1]['Location']
  end
  
  expect '' do
    QueueItem.stubs(:create).returns(stub(:id => 5))
    c = QueueItemsController.new({})
    c.stubs(:params).returns({})
    c.call(:create).last
  end
  
  expect QueueItem.to.receive(:pop).returns({}) do
    c = QueueItemsController.new({})
    c.call(:show)
  end
  
  expect String do
    QueueItem.stubs(:pop).returns({})
    c = QueueItemsController.new({})
    c.call(:show).last
  end
end

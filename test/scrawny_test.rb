require File.dirname(__FILE__)+'/test_helper'

Expectations do
  expect ActiveRecord::Base.to.receive(:establish_connection) do
    Scrawny::QueueItem.stubs(:table_exists?).returns(true)
    Thin::Server.any_instance.stubs(:start)
    Scrawny.start!
  end
  
  expect ActiveRecord::Migration.to.receive(:create_table).with(:queue_items) do
    ActiveRecord::Base.stubs(:establish_connection)
    Scrawny::QueueItem.stubs(:table_exists?).returns(false)    
    Scrawny.send(:establish_db_connection)
  end
  
  expect ActiveRecord::Migration.to.receive(:create_table).times(0) do
    ActiveRecord::Base.stubs(:establish_connection)
    Scrawny::QueueItem.stubs(:table_exists?).returns(true)
    Scrawny.send(:establish_db_connection)
  end
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
require File.dirname(__FILE__)+'/../vendor/invisible/lib/invisible'
%w(rubygems activesupport activerecord thin scrawny/queue_item scrawny/queue_items_controller ).each { |l| require l }

module Scrawny
  class << self
    def start!
      establish_db_connection
      
      @server = Thin::Server.new '0.0.0.0', 5432 do
        map('/') { run Invisible::Application.new }
      end
      
      @server.start
    end
    
    def stop!
      @server.stop if @server
    end
    
    protected
      def establish_db_connection
        ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "queue.sqlite3")
        
        unless QueueItem.table_exists?
          ActiveRecord::Migration.create_table :queue_items do |t|
            t.text :value
          end
        end
      end
  end
end

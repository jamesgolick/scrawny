$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'activesupport'
require 'activerecord'
require 'thin'
require File.dirname(__FILE__)+'/../vendor/invisible/lib/invisible'

module Scrawny
  class << self
    def start!
      @server = Thin::Server.new '0.0.0.0', 5432 do
        map('/') { run Invisible::Application.new }
      end
      
      @server.start
    end
    
    def stop!
      @server.stop if @server
    end
  end
end

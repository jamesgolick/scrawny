require File.dirname(__FILE__)+'/test_helper'
require 'rack/mock'

include Invisible

def controller_instance_var(var)
  Controller.new(Rack::MockRequest.env_for('/test')).instance_variable_get("@#{var}")
end

def default_headers
  {'Content-Type' => 'text/html'}
end

Expectations do
  expect Rack::Request do
    controller_instance_var('request')
  end
  
  expect 200 do
    controller_instance_var('status')
  end
  
  expect nil do
    controller_instance_var('body')
  end
  
  expect(default_headers) do
    controller_instance_var('headers')
  end
  
  expect [200, default_headers, 'mockbody'] do
    c = Controller.new(Rack::MockRequest.env_for('/test'))
    c.stubs(:index).returns('mockbody')
    c.call(:index)
  end
  
  expect({'value' => 'asdf'}) do
    xml = %{
<?xml version="1.0" encoding="UTF-8"?>
<queue-item>
  <value>asdf</value>
</queue-item>}

    c = Controller.new(Rack::MockRequest.env_for('/test'))
    c.instance_variable_get('@request').stubs(:body).returns(StringIO.new << xml)
    c.instance_variable_get('@request').stubs(:[]).returns('application/xml')
    c.send(:supplement_params)
    c.send(:params)[:queue_item]
  end
end

require File.dirname(__FILE__)+'/test_helper'

include Invisible

def controller_instance_var(var)
  Controller.new({}).instance_variable_get("@#{var}")
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
    c = Controller.new({})
    c.stubs(:index).returns('mockbody')
    c.call(:index)
  end
end

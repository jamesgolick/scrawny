require File.dirname(__FILE__)+'/test_helper'

include Invisible

class TestController < Controller
  def index; end
end

Expectations do
  
  expect :create do
    Application.new.send(:action_for, 'POST', '')
  end
  
  expect :update do
    Application.new.send(:action_for, 'PUT', 'something')
  end
  
  expect :index do
    Application.new.send(:action_for, 'GET', '')
  end
  
  expect :show do
    Application.new.send(:action_for, 'GET', 'something')
  end
  
  expect :destroy do
    Application.new.send(:action_for, 'DELETE', 'something')
  end
  
  expect TestController.to.receive(:new).returns(stub_everything) do
    Application.new.call({'PATH_INFO' => '/test'})
  end
  
  expect TestController.any_instance.to.receive(:call).with(:create) do
    Application.new.call({'PATH_INFO' => '/test', 'REQUEST_METHOD' => 'POST'})
  end
end

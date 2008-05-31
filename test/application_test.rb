require File.dirname(__FILE__)+'/test_helper'

include Scrawny::Invisible

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
  
end

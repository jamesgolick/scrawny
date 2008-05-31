require 'activeresource'

module Scrawny
  module Client
    class QueueItem < ActiveResource::Base
      self.site = 'http://localhost:5432'
    end
  end
end

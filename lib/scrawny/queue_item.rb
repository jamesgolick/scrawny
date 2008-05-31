module Scrawny
  class QueueItem < ActiveRecord::Base
    def self.pop
      returning find(:first, :order => 'created_at ASC') do |next_item|
        next_item.destroy
      end
    end
  end
end

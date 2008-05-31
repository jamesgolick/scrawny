module Scrawny
  class QueueItemsController < ::Invisible::Controller
    def create
      QueueItem.create(params[:queue_item])
    end
    
    def delete_collection
      QueueItem.pop
    end
  end
end

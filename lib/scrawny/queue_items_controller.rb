module Scrawny
  class QueueItemsController < ::Invisible::Controller
    def create
      @queue_item = QueueItem.create(params[:queue_item])
      @headers['Location'] = "/queue_items/#{@queue_item.id}"
      ''
    end
    
    def delete_collection
      QueueItem.pop
    end
  end
end

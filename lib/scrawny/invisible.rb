module Scrawny
  module Invisible
    
    class Application
      def call(env)
        _, controller, action = env["PATH_INFO"].split("/")
        Object.const_get("#{(controller || 'home').capitalize}Controller").new(env).call(action || 'index')
      end
    end

    class Controller
      def initialize(env)
        @status  = 200
        @headers = { 'Content-Type' => 'text/html' }
        @body    = nil
        @request = Rack::Request.new(env)
      end

      def call(action)
        @body = send(action)
        [@status, @headers, @body]
      end
      
      protected
        def params
          @params ||= @request.params.symbolize_keys
        end
    end
    
  end
end

%w(rubygems activesupport thin rack).each { |l| require l }

module ::Invisible
  
  class Application
    MEMBER_ACTIONS     = { 'PUT'  => :update, 'DELETE' => :destroy, 'GET' => :show }
    COLLECTION_ACTIONS = { 'POST' => :create, 'GET'    => :index }
    
    def call(env)
      _, controller, action = env["PATH_INFO"].split("/")
      Object.const_get("#{(controller || 'home').capitalize}Controller").new(env).call(action_for(env['REQUEST_METHOD'], action))
    end
    
    protected
      def action_for(method, path)
        action_hash = path.blank? ? COLLECTION_ACTIONS : MEMBER_ACTIONS
        action_hash[method]
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

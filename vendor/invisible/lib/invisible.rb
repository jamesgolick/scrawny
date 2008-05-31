%w(rubygems activesupport rack).each { |l| require l }

module ::Invisible
  
  class Application
    cattr_accessor :controllers_module
    self.controllers_module = Object
    
    MEMBER_ACTIONS     = { 'PUT'  => :update, 'DELETE' => :destroy, 'GET' => :show }
    COLLECTION_ACTIONS = { 'POST' => :create, 'GET'    => :index }
    
    def call(env)
      _, controller, action = env["PATH_INFO"].split("/")
      controller.gsub!(/\..*/, '')
      controllers_module.const_get("#{(controller || 'home').camelize}Controller").new(env).call(action_for(env['REQUEST_METHOD'], action))
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
      @env     = env
      @request = Rack::Request.new(env)
      
      supplement_params
    end

    def call(action)
      @body = send(action)
      [@status, @headers, @body]
    end
    
    protected
      def params
        @params ||= @request.params.to_hash.with_indifferent_access
      end
      
      def supplement_params
        params.merge!(Hash.from_xml(@request.body.string).with_indifferent_access) if %w( application/xml text/xml application/x-xml ).include?(@request.env['CONTENT_TYPE']) && !@request.body.string.blank?
      end
  end
  
end

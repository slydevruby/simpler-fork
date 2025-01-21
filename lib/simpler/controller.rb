# frozen_string_literal: true

require 'rack/response'

module Simpler
  class Controller
    STATUS = { ok: 200, not_found: 404 }.freeze

    attr_reader :name

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      status(:ok)
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      send(action)
      set_content_type('text', 'html')
      write_response
      write_log
      @response.finish
    end

    def params
      @request.params
    end

    private

    def fetch_env(key)
      @request.env.fetch(key)
    end

    def write_log
      Logger.info("Request #{fetch_env('REQUEST_METHOD')} #{fetch_env('REQUEST_URI')}")
      action = fetch_env('simpler.action')
      Logger.info("Handler #{self.class.name}##{action}")
      Logger.info("Response #{@response.status} [#{@response.content_type}] #{@name}/#{action}.html.erb")
    end

    def status(value)
      @response.status = STATUS[value]
    end

    def render(template)
      if template.instance_of?(::Hash)
        method_and_template(template.keys[0].to_s, template.values[0])
      else
        method_and_template('html', template)
      end
    end

    def method_and_template(method, template)
      @request.env['simpler.method'] = method
      @request.env['simpler.template'] = template
      set_content_type('text', method)
    end

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_content_type(content, type)
      @response['Content-Type'] = "#{content}/#{type}"
    end

    def write_response
      body = render_body
      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end
  end
end

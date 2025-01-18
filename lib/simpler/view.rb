# frozen_string_literal: true

require 'erb'
require 'cgi'

# some comment
module Simpler
  # class View
  class View
    VIEW_BASE_PATH = 'app/views'

    def initialize(env)
      @env = env
    end

    def render(binding)
      case template_method
      when 'plain'
        ERB.new("#{template}\n").result(binding)
      when 'json'
        CGI.parse(template)
      else # 'html'
        file = File.read(template_path)
        ERB.new(file).result(binding)
      end
    end

    private

    def controller
      @env.fetch('simpler.controller')
    end

    def action
      @env.fetch('simpler.action')
    end

    def template
      @env.fetch('simpler.template', nil)
    end

    def template_method
      @env.fetch('simpler.method', nil)
    end

    def template_path
      path = template || [controller.name, action].join('/')
      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end
  end
end

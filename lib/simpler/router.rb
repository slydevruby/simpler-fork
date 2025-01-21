# frozen_string_literal: true

require_relative 'router/route'

module Simpler
  class Router
    def initialize
      @routes = []
    end

    def get(path, route_point)
      add_route(:get, path, route_point)
    end

    def post(path, route_point)
      add_route(:post, path, route_point)
    end

    def route_for(env)
      method = env.fetch('REQUEST_METHOD').downcase.to_sym
      path = env.fetch('PATH_INFO')
      @routes.find { |route| route.match?(method, path) }
    end

    private

    def parse_arguments_from(path)
      args = path.gsub(%r{/[:\w]*}).to_a.map { |x| x.delete('/') }[1..]
      args.map do |x|
        if /^:/ =~ x
          { x => :dynamic }
        else
          { x => :static }
        end
      end
    end

    def add_route(method, path, route_point)
      args = parse_arguments_from(path)

      ctrl, action = route_point.split('#')
      controller = controller_from_string(ctrl)
      route = Route.new(method, path, controller, action, args)
      @routes.push(route)
    end

    def controller_from_string(str)
      Object.const_get("#{str.capitalize}Controller")
    end
  end
end

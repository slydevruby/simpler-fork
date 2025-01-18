# frozen_string_literal: true

require_relative 'router/route'

module Simpler
  # Router
  class Router
    def initialize
      @routes = []
    end

    def get(path, route_point)
      puts("get path:#{path}, route_point:#{route_point}")
      add_route(:get, path, route_point)
    end

    def post(path, route_point)
      add_route(:post, path, route_point)
    end

    def route_for(env)
      method = env.fetch('REQUEST_METHOD').downcase.to_sym
      path = env.fetch('PATH_INFO')
      puts("Router.route_for path #{path}")
      @routes.find { |route| route.match?(method, path) }
    end

    private

    def add_route(method, path, route_point)
      ctrl, action = route_point.split('#')
      puts("Router.add_route action #{action}")
      controller = controller_from_string(ctrl)
      route = Route.new(method, path, controller, action)
      @routes.push(route)
    end

    def controller_from_string(str)
      Object.const_get("#{str.capitalize}Controller")
    end
  end
end

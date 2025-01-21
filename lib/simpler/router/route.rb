# frozen_string_literal: true

# Simpler
module Simpler
  class Router
    class Route
      attr_reader :controller, :action, :args

      def initialize(method, path, controller, action, args)
        @method = method
        @path = path
        @controller = controller
        @action = action
        puts "Route new method: #{method}, path: #{path}, action: #{action}, args #{args}"
        @args = args
      end

      def match?(method, path)
        puts "match? #{method} #{path} @path: #{@path}"
        @method == method && path.match(@path)
      end
    end
  end
end

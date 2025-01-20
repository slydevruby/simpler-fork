# frozen_string_literal: true

# Simpler
module Simpler
  # Router
  class Router
    # Route
    class Route
      attr_reader :controller, :action, :args

      def initialize(method, path, controller, action, args)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @args = args
      end

      def match?(method, path)
        @method == method && path.match(@path)
      end
    end
  end
end

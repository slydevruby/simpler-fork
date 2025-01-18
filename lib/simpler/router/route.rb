# frozen_string_literal: true

# Simpler
module Simpler
  # Router
  class Router
    # Route
    class Route
      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path.match(@path)
      end
    end
  end
end

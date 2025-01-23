# frozen_string_literal: true

# Simpler
module Simpler
  class Router
    class Route
      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        if simple_path?
          @method == method && path.match(@path)
        else
          @method == method && xooo(path)
        end
      end

      private

      def simple_path?
        @path.split('/').size <= 2
      end

      def xooo(path)
        internal = @path.split('/')
        external = path.split('/')

        for i in 2..internal.size - 1 do
          next unless internal[i].match?(':')

          x = internal[i].split(':').last.to_sym
          @params[x] = external[i]
        end
        internal.size == external.size
      end
    end
  end
end

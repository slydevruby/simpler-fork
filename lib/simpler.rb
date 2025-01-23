# frozen_string_literal: true

require_relative 'simpler/application'
require_relative 'simpler/controller'
require_relative 'simpler/view'

module Simpler
  class << self
    def application
      Application.instance
    end

    def root
      Pathname.new(File.expand_path('..', __dir__))
    end
  end
end

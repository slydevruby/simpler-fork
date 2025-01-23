# frozen_string_literal: true

# Namespace
module Simpler
  module Logger
    @@log = File.open('log/app.log', 'a+')

    def self.info(msg)
      @@log.puts("#{Time.now}\t#{msg}")
      @@log.flush
    end
  end
end

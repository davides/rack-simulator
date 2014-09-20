require "rack/simulator/writer"

module Rack
  module Simulator
    # Decorator for Rack::StreamingProxy::Response
    # that saves the response as it is being read.
    class RecordingResponse
      include Logging

      attr_reader :status, :headers

      def initialize(writer, response)
        @writer = writer
        @response = response
        @status = @response.status
        @headers = @response.headers
      end

      # Called by rack to build the response body.
      def each
        log :info, "each()"
        @writer.open do |w|
          @response.each do |chunk|
            w.write(chunk)
            yield(chunk)
          end
        end
      end
    end
  end
end
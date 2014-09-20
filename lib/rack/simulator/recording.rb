require "rack/streaming_proxy"

module Rack
  module Simulator
    class Recording 
      def initialize(app, options={}, &block)
        @inner = Rack::StreamingProxy::Proxy.new(app, &block)
        @options = default_options.merge(options)
      end

      def call(env)
        input = record_request(env)
        response = @inner.call(env)
        input.writer.close
        record_response(response)
      end

      # Decorate env["rack.input"]
      # with Rack::Simulator::RecordingInput so that
      # request body contents get recorded as they're read.
      def record_request(env)
        input = create_recording_input(env)
        env.update "rack.input" => input
        input
      end

      # Decorate Rack::StreamingProxy::Response 
      # with Rack::Simulator::RecordingResponse so that
      # response body contents get recorded as they arrive.
      def record_response(response)
        response[2] = create_recording_response(response[2])
        response
      end

      def create_recording_input(env)
        w = Writer.from_request(Rack::Request.new(env), @options)
        RecordingInput.new(w, env["rack.input"])
      end

      def create_recording_response(response)
        w = Writer.from_response(response, @options)
        RecordingResponse.new(w, response)
      end

      def default_options
        {}
      end
    end
  end
end
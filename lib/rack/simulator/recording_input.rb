module Rack
  module Simulator
    class RecordingInput
      include Logging

      attr_reader :writer

      def initialize(writer, input)
        @writer = writer
        @input = input
      end

      def gets
        log :info, "gets()"
        result = @input.gets
        @writer.puts result
        result
      end

      def read(*args)
        log :info, "read()"
        result = @input.read(*args)
        @writer.write result
        result
      end

      def each(&block)
        log :info, "each()"
        @writer.open do |w|
          @input.each do |chunk|
            w.write(chunk)
            yield(chunk)
          end
        end
      end

      def rewind
        log :info, "rewind()"
        @input.rewind
      end

      def close
        log :info, "close()"
        @writer.close
      end
    end
  end
end
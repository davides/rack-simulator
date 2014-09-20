module Rack
  module Simulator
    class Writer
      include Logging

      def initialize(file_path)
        log :info, "initialize(#{file_path})"
        @file_path = file_path
      end

      def write(str); log :info, "write()"; file.write(str); end

      def puts(obj); log :info, "puts()"; file.puts(obj); end

      def close; log :info, "close()"; @file.close if @file; @file = nil; end

      def open
        log :info, "open()"
        ensure_file_path
        ::File.open(@file_path, "a") do |f|
          yield(f) if block_given?
        end
      end

      def file
        ensure_file_path
        @file ||= ::File.open(@file_path, "a")
      end

      def ensure_file_path
        dir = ::File.dirname(@file_path)
        FileUtils.mkdir_p(dir) if !::File.directory?(dir)
      end

      def self.from_request(request, options)
        request_method = request.request_method
        request_path = request.path
        request_path = request_path[1..-1] if request_path[0] == "/"
        request_path.gsub! /\//, "-"
        file_name = "#{DateTime.now}__#{request_method}__#{request_path}"
        file_path = ::File.join(options[:trace_dir], "requests", file_name)
        self.new(file_path)
      end

      def self.from_response(response, options)
        file_name = "#{DateTime.now}__#{response.status}"
        file_path = ::File.join(options[:trace_dir], "responses", file_name)
        self.new(file_path)
      end
    end
  end
end
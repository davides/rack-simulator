module Rack
  module Simulator
    module Logging
      def log(severity, message)
        Simulator.log.send(severity, "[#{self.class.name}] #{message}")
      end
    end
  end
end
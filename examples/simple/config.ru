current_dir = File.dirname(__FILE__)
trace_dir = File.join(current_dir, 'traces')
$LOAD_PATH << File.join(current_dir, '../..', 'lib')

require 'rack'
require 'rack/simulator'

use Rack::Simulator::Recording, { :trace_dir => trace_dir } do |request|
  "http://localhost:4567#{request.path}"
end

# simulator will proxy everything but still need to call run
run Proc.new {}
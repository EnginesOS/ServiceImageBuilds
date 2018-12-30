require File.expand_path '/opt/engines/src/server/engine_server.rb', __FILE__
 STDERR.puts('+')
run Sinatra::Application

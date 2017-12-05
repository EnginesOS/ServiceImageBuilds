require File.expand_path   '/home/app/control/v0/module', __FILE__
#run Sinatra::Application
map('/') { run V0 }
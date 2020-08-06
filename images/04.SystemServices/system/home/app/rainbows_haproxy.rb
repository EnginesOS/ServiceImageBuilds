
app_path = File.expand_path(File.dirname(__FILE__))
timeout 600
working_directory app_path
stderr_path '/var/log/rainbows_err.log'
stdout_path '/var/log/rainbows.log'
preload_app true
Rainbows! do
  use :ThreadSpawn # concurrency model to use
  worker_connections 40
  keepalive_timeout 330 # zero disables keepalives entirely
  # FixME this should be limited to certain routes
  client_max_body_size 10 * 1024*1024*1024 # 10 GB
  keepalive_requests 100 # default:100
  client_header_buffer_size 4 * 1024 # 2 kilobytes
end

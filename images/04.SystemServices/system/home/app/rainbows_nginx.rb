
app_path = File.expand_path(File.dirname(__FILE__))
timeout 300
working_directory app_path
stderr_path '/var/log/rainbows_err.log'
stdout_path '/var/log/rainbows.log'
preload_app true
listen  '/tmp/rainbows.sock', backlog: 64

Rainbows! do
  use :ThreadSpawn # concurrency model to use
  worker_connections 40
  keepalive_timeout 0 # zero disables keepalives entirely
  # FixME this should be limited to certain routes
  client_max_body_size 10 * 1024*1024*1024 # 10 GB
  keepalive_requests 666 # default:100
  client_header_buffer_size 2 * 1024 # 2 kilobytes
end

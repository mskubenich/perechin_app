worker_processes 2
working_directory "/home/perechin/perechin_app/"

preload_app true

timeout 30

listen "/home/perechin/perechin_app/tmp/sockets/unicorn.sock", :backlog => 64

pid "/home/perechin/perechin_app/tmp/pids/unicorn.pid"

stderr_path "/home/perechin/perechin_app/log/unicorn.stderr.log"
stdout_path "/home/perechin/perechin_app/log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
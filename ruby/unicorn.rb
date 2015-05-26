# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
@dir = File.dirname(__FILE__)

worker_processes 8
working_directory @dir

timeout 30

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen '0.0.0.0:9000', :backlog => 64

# Set process id path
pid ENV.fetch('unicorn_pid', '/var/run/unicorn.pid')

# Set log file paths
stderr_path ENV.fetch('unicorn_stderr', '/var/log/unicorn.stderr.log')
stdout_path ENV.fetch('unicorn_stdout', '/var/log/unicorn.stdout.log')

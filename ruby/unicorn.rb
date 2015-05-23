# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
@dir = File.expand_path "."

worker_processes 8
working_directory @dir

timeout 30

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen "0.0.0.0:9000", :backlog => 64

# Set process id path
pid "/var/run/unicorn.pid"

# Set log file paths
stderr_path "/var/log/unicorn.stderr.log"
stdout_path "/var/log/unicorn.stdout.log"
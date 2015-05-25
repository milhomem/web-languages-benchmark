workers 8
threads 100,100
bind 'tcp://0.0.0.0:9000'
# pidfile "/var/run/puma.pid"
directory File.dirname(__FILE__)
preload_app!

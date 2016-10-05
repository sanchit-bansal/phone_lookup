threads_count = Integer(ENV['MAX_THREADS'] || 4)
threads threads_count, threads_count

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

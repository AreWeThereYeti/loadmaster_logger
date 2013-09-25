# if Rails.env=="production"
#   Mongoid.database = Mongoid::Connection.new('195.231.85.192',27017) # production env
# else
#   Mongoid.database = Mongoid::Connection.new('localhost', 27017) # local env
# end
# 
# Mongoid.database = "#myapp-#{Rails.env}"
# 
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    Mongoid.connection.connect if forked
  end
end
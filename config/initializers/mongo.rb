if Rails.env=="production"
  MongoMapper.connection = Mongo::Connection.new('195.231.85.192',27017) # production env
else
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017) # local env
end

MongoMapper.database = "#myapp-#{Rails.env}"

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end
# for local env:
#MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
# for production env:
MongoMapper.connection = Mongo::Connection.new('195.231.85.192',27017)
MongoMapper.database = "#myapp-#{Rails.env}"

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    MongoMapper.connection.connect if forked
  end
end
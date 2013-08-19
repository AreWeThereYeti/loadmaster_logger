class Trip
  include Mongoid::Document
  
  field :license_plate, type: String
  field :device_id, type: String
  field :cargo, type: String
  field :start_location, type: Array #[lat, lon]
  field :start_address, type: String
  field :end_location, type: Array #[lat, lon]
  field :end_address, type: String
  field :start_timestamp, type: Float
  field :end_timestamp, type: Float
  field :weight, type: Float
  field :costumer, type: String
  field :commentary, type: String
  
  field :access_token, type: String
  
end

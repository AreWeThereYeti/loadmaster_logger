class Trip
  include Mongoid::Document
  include Mongoid::Search
  
  has_and_belongs_to_many :users

  attr_accessor :start_lat
  attr_accessor :start_lon
  attr_accessor :end_lat
  attr_accessor :end_lon
  
  field :license_plate, type: String
  field :device_id, type: String
  field :cargo, type: String
  field :start_location, type: Array #[lat,lon]
  field :start_address, type: String
  field :end_location, type: Array #[lat,lon]
  field :end_address, type: String
  field :start_timestamp, type: Time
  field :end_timestamp, type: Time
  field :weight, type: Float
  field :costumer, type: String
  field :start_comments, type: String
  field :end_comments, type: String
  
  field :user_id, type: String
  field :access_token, type: String
  
  field :chauffeur, type: String
  field :distance, type: Float
  
  validates_presence_of :license_plate, :cargo, :start_timestamp, :end_timestamp
    
  search_in :start_address, :end_address, :cargo, :license_plate, :costumer, :weight
  
end

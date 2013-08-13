class Role
  include Mongoid::Document
  
  has_and_belongs_to_many :users
  field :name,              :type => String, :default => ""
  
  
end
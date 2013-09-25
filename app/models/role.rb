class Role
  include Mongoid::Document
  
  has_and_belongs_to_many :users
  before_save :check_if_exists
  
  field :name,              :type => String, :default => ""
  
  def check_if_exists
    if !Role.where(:name => self[:name]).nil? 
      if !Role.where(:name => self[:name]).first.nil?
        return false
      end
    end
  end
  
end

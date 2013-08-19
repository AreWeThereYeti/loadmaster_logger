class ApiKey
  include Mongoid::Document
  
  field :access_token
  field :user_id
  field :expire_at
    
  before_create :generate_access_token
  
private
  
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while ApiKey.where( access_token: self.access_token ).exists?
  end

end
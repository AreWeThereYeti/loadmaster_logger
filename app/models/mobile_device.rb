class MobileDevice
  include Mongoid::Document
  
  field :device_id
  field :access_token
  field :user_id
  
  before_create :generate_access_token
  
  private

    def generate_access_token
      puts 'generating api_key'
      self.access_token=ApiKey.create![:access_token]
      self.access_token
    end
  
end

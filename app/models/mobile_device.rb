class MobileDevice
  include Mongoid::Document
  include Mongoid::Search
  
  field :device_id
  field :access_token
  field :user_id
  field :username
    
  search_in :device_id, :username
  
  before_create :generate_access_token, :get_username
  
  private

    def generate_access_token
      self.access_token=ApiKey.create![:access_token]
    end
    
    def get_username
      self.username=User.where(:id => self.user_id).first.username.to_s
      self._keywords.push(self.username)    #remember to add to keywords
    end
end

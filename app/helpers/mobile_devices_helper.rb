module MobileDevicesHelper
  
  def username(device)
   return User.where(:id => device.user_id).first.username.to_s
  end
  
end

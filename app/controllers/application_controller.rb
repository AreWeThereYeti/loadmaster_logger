class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # before_filter :verify_login
  
  # def verify_login
  #   puts 'verify_login ran'
  #   if current_user.nil?
  #     redirect_to '/users/sign_in'
  #   end
  # end
  
  def has_role?(current_user, role)
    return !!Role.find_by(:name => role.to_s.camelize)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  
  before_filter :authenticate_user!
  
  def has_role?(current_user, role)
    return !!Role.find_by(:name => role.to_s.camelize)
  end

  rescue_from CanCan::AccessDenied do |exception|
    puts '------------access denied ran!!!!!-------------'
    puts exception
    redirect_to root_url, :alert => exception.message
  end
  
  def unauthorized_ressource_redirect
    redirect_to root_url, :alert => "You are not authorized to access this ressource"
  end
  
end

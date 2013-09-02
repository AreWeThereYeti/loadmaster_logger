class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery
  
  helper ApplicationHelper
  
  before_filter :authenticate_user!
  
  def has_role?(role)
    return !!Role.find_by(:name => role.to_s.camelize)
  end

  rescue_from CanCan::AccessDenied do |exception|
    puts '------------access denied!!!!!-------------'
    puts exception
    redirect_to root_url, :alert => exception.message
  end
  
  def unauthorized_ressource_redirect
    redirect_to root_url, :alert => "You are not authorized to access this ressource"
  end
  
  private
  
    def verify_admin
      :authenticate_user!
      redirect_to root_url, :alert => "You are not authorized to access this ressource" unless current_user.role? :admin, current_user.role_id
    end
    
    def get_timestamp(hash)
        return Time.new(hash[:year],hash[:month],hash[:day],hash[:hour],hash[:minute])
    end
    
    def string_search(search_str,the_model,max_results)
      search_str.kind_of?(Array) ? @search_str=search_str.first.to_s : @search_str=search_str.to_s
      the_model.full_text_search(@search_str, {:max_results => max_results})
    end
    
end

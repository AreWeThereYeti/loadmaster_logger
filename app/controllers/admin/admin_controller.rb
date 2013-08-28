class Admin::AdminController < ApplicationController
  layout "admin"
  before_filter :verify_admin

  def verify_admin
    :authenticate_user!
    #redirect_to root_url, :alert => "You are not authorized to access this ressource" unless current_user.role? :admin
  end

  # def current_ability
  #   @current_ability ||= Ability.new(current_user)
  # end
  
  
  private
  
    def user_params
      params.require(:user).permit(
        :username,
        :email,
        :password,
        :password_confirmation,
        :role_id,
        :user_id)
    end
end
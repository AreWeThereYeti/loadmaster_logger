class Admin::AdminController < ApplicationController
  layout "admin"
  before_filter :verify_admin

  def verify_admin
    :authenticate_user!
    redirect_to root_url, :alert => "You are not authorized to access this ressource" unless current_user.role? :admin, current_user.role_ids[0]
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_user)
  end
end
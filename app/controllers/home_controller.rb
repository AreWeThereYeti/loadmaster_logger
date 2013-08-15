class HomeController < ApplicationController
  
  def index
    puts 'rendering index'
    unless current_user
      redirect_to '/users/sign_in'
    end
  end
  
end

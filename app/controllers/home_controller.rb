class HomeController < ApplicationController
  
  def index
    if current_user
      redirect_to '/trips'
    else
      redirect_to '/users/sign_in'
    end
  end
  
end

class UserController < ApplicationController
  
  def create 
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed Up!"
    else
      render 'new'
    end
  end
  
end

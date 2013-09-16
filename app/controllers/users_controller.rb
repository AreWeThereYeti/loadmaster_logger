class UsersController < ApplicationController
  
  load_and_authorize_resource
  before_filter :match_self, :authenticate_user!
  attr_accessor :user

  
  # def current_ability
  #   @current_ability ||= Ability.new(current_user)
  # end
  
  # GET /users/1
  # GET /users/1.json
  def show
    puts '----------- show ran with current_user: ---------'
    puts current_user
    @user = User.find(params[:id])
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    puts 'edit ran is user controller'
    @user = User.find(params[:id])
  end
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank?
        params[:user].delete(:password)
    end
 
    respond_to do |format|
      if @user.update_attributes(user_params)
        puts '------------------user was updated-----------------'
        sign_in @user, :bypass => true #should be if password is updated
        format.html { render :action => 'show', :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to '/', :notice => 'Your profile was successfully deleted' }
      format.json { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(
        :username,
        :email,
        :password,
        :password_confirmation,
        :cvr,
        :company_address)
    end
    
    def match_self
      if params[:id] == 'self' || params[:id] == 'me'
        @user = current_user
      elsif params[:id]
        @user = User.find(params[:id])
      end
      @user = current_user #if user.blank?
    end
  
end

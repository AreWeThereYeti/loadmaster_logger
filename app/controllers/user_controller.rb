class UserController < ApplicationController
  
  load_and_authorize_resource
  before_filter :authenticate_user!

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
      
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end
  
  # PUT /users/1
  # PUT /users/1.json
  def update
    puts 'update ran in user controller'
    @user = User.find(params[:id])
    if params[:user][:password].blank?
        params[:user].delete(:password)
    end
 
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { render :action => 'show', :id => @user.id, :notice => 'User was successfully updated.' }
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
      format.html { redirect_to admin_users_url }
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
        :password_confirmation)
    end
  
end

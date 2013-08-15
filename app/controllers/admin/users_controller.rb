class Admin::UsersController < ApplicationController
  load_and_authorize_resource except: [:create]
  
  layout "admin"
  before_filter :verify_admin

  def verify_admin
    :authenticate_user!
    redirect_to root_url, :alert => "You are not authorized to access this ressource" unless current_user.role? :admin, current_user.role_ids[0]
  end

  # def current_ability
  #   @current_ability ||= AdminAbility.new(current_user)
  # end
  
  # GET /users
  # GET /users.json
  def index
    puts '----user controller index loading-------'
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    puts '---- creating new user ------'
    @user = params[:user]
    @user[:role_ids] = params[:user][:role_ids] if params[:user]
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        format.html { redirect_to admin_users_path, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        puts 'save error'
        puts @user.errors.full_messages
        flash[:notice] = flash[:notice].to_a.concat @user.errors.full_messages
        format.html { render :action => "new"}
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank?
        params[:user].delete(:password)
    end
 
    respond_to do |format|
      puts 'user params:'
      puts user_params
      puts 'user params role:'
      puts user_params[:role_ids]
      if @user.update_attributes(user_params)
        format.html { redirect_to admin_users_path, :notice => 'User was successfully updated.' }
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
        :email,
        :password,
        :password_confirmation,
        # roles_attributes:[:role_ids],
        :role_ids => [])
    end
end

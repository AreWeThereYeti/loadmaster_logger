class Admin::UsersController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_filter :verify_admin
  
  helper_method :sort_column, :sort_direction
  
  layout "admin"
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all.order_by([[sort_column, sort_direction]]).page(params[:page]).per(25)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @mobile_devices = MobileDevice.where(:user_id => params[:id].to_s)
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
  
  def new_mobile
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
    @user = params[:user]
    @user[:role_id] = params[:user][:role_id] if params[:user]
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
    puts 'ran update in admin controller'
    @user = User.find(params[:id])
    if params[:user][:password].blank?
        params[:user].delete(:password)
    end
 
    respond_to do |format|
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
  
  def search
    if params[:search].empty? || params[:search][0].empty?
      redirect_to admin_users_path
    else
      @users = sort_search_results(string_search(params[:search],User,max_search_results))
      render 'index'
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
        :role_id)
    end
    
    def sort_column
      User.fields.keys.include?(params[:sort]) ? params[:sort] : 'username'
    end

end

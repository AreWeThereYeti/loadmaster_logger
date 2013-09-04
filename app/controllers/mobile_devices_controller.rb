class MobileDevicesController < ApplicationController
  before_action :set_mobile_device, only: [:show, :edit, :update, :destroy]
  before_filter :verify_admin
  helper_method :user, :sort_column, :sort_direction
  

  # GET /mobile_devices
  # GET /mobile_devices.json
  def index
    @mobile_devices = MobileDevice.all.order_by([[sort_column, sort_direction]]).page(params[:page]).per(results_per_page)
  end

  # GET /mobile_devices/1
  # GET /mobile_devices/1.json
  def show
    @mobile_device = MobileDevice.find(params[:id])
    @mobile_device_user = User.where(:id => @mobile_device.user_id).first.username
  end

  # GET /mobile_devices/new
  def new
    @mobile_device = MobileDevice.new
    @haulers = User.where(:role_id => Role.find_by("name" => "Hauler").id.to_s)
  end

  # GET /mobile_devices/1/edit
  def edit
    @haulers = User.where(:role_id => Role.find_by("name" => "Hauler").id.to_s)
  end

  # POST /mobile_devices
  # POST /mobile_devices.json
  def create
    @mobile_device = MobileDevice.new(mobile_device_params)
    respond_to do |format|
      if @mobile_device.save        
        if !User.find_by(:id => @mobile_device.user_id.to_s).add_to_set(:devices => @mobile_device.id)
          format.html { render action: 'new' }
        end
        format.html { redirect_to @mobile_device, notice: 'Den mobile enhed blev oprettet. Indtast nu denne kode på dit android device: '+ @mobile_device.access_token.to_s }
        format.json { render action: 'show', status: :created, location: @mobile_device }
      else
        format.html { render action: 'new' }
        format.json { render json: @mobile_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mobile_devices/1
  # PATCH/PUT /mobile_devices/1.json
  def update
    @haulers = User.where(:role_id => Role.find_by("name" => "Hauler").id.to_s)
    respond_to do |format|
      if @mobile_device.update(mobile_device_params)
        format.html { redirect_to @mobile_device, notice: 'Mobile device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mobile_device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mobile_devices/1
  # DELETE /mobile_devices/1.json
  def destroy
    @mobile_device.destroy
    respond_to do |format|
      format.html { redirect_to mobile_devices_url }
      format.json { head :no_content }
    end
  end
  
  def search
    if params[:search].empty? || params[:search][0].empty?
      redirect_to mobile_devices_path
    else
      @mobile_devices = sort_search_results(string_search(params[:search],MobileDevice,max_search_results))
      render 'index'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile_device
      @mobile_device = MobileDevice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mobile_device_params
      params.require(:mobile_device).permit(
        :device_id,
        :user_id,
        :username)
    end
    
    def verify_admin
      :authenticate_user!
      redirect_to root_url, :alert => "You are not authorized to access this ressource" unless current_user.role? :admin, current_user.role_id
    end
    
    def sort_column
      MobileDevice.fields.keys.include?(params[:sort]) ? params[:sort] : 'username'
    end
end

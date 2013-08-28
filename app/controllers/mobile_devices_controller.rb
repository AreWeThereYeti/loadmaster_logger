class MobileDevicesController < ApplicationController
  before_action :set_mobile_device, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /mobile_devices
  # GET /mobile_devices.json
  def index
    @mobile_devices = MobileDevice.all
  end

  # GET /mobile_devices/1
  # GET /mobile_devices/1.json
  def show
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
        
        format.html { redirect_to @mobile_device, notice: 'Mobile device was successfully created.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mobile_device
      @mobile_device = MobileDevice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mobile_device_params
      params.require(:mobile_device).permit(
        :device_id,
        :user_id)
    end
end

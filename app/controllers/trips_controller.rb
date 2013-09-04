class TripsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  
  helper_method :sort_column, :sort_direction

  # GET /trips
  # GET /trips.json
  def index
    @trips = Trip.where(:user_id => current_user.user_id).order_by([[sort_column, sort_direction]]).page(params[:page]).per(25) 
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)
    @trip.start_timestamp=get_timestamp(params[:start_timestamp])
    @trip.end_timestamp=get_timestamp(params[:end_timestamp])
    
    @trip.user_id=current_user.id
    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render action: 'show', status: :created, location: @trip }
      else
        format.html { render action: 'new' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end
  
  def search
    if params[:search].empty? || params[:search][0].empty?
      redirect_to trips_path
    else
      @trips = sort_search_results(string_search(params[:search],Trip,max_search_results))
      render 'index'
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(
        :license_plate,
        :device_id,
        :cargo,
        :start_location,
        :start_address,
        :end_location,
        :end_address,
        :start_timestamp,
        :end_timestamp,
        :weight,
        :costumer,
        :commentary,
        :user_id)
    end
    
    def sort_column
      Trip.fields.keys.include?(params[:sort]) ? params[:sort] : 'start_timestamp'
    end
    
end

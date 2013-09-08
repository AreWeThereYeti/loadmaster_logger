module Api
  module V1
    
    class TripsController < ApplicationController
      
      # Example for overwriting a hashed attribute to a new version of API (see http://railscasts.com/episodes/350-rest-api-versioning)
      # 
      # class Trip < ::Trip
      #   # Note: this does not take into consideration the create/update actions for changing released_on
      #   def as_json(options = {})
      #     super.merge(startdate: startdate.to_date)
      #   end
      # end
      
      #before_filter :authenticate_user!, except: [:create]  #overwrite devise and cancan auth
      skip_before_filter :authenticate_user!
      skip_before_filter :verify_authenticity_token#, :if => Proc.new { |c| c.request.format == 'application/json' }
      before_filter :restrict_access
      
      respond_to :json
      
      # def index
      #   respond_with Trip.all
      # end
      
      # action takes hash of trips and saves them in DB
      def create
        err_objs=[]
        error=false
        user_id=MobileDevice.where(:access_token=>params[:access_token]).first.user_id
        params[:trips].each do |trip|
          trip_id=trip[1][:trip_id]         #save ref to trip id in case @trip.save fails (used in return response)
          if !create_trip(trip[1],user_id)
            error=true
            err_objs.push(trip_id)
          end
        end
        respond_to do |format|
          if !error
            format.json { render json: 'success', status: :created }
          else
            format.json { render json: {:msg => "Could not save the following trips. Please check that all required fields are filled out (license_plate, cargo, start_location, end_location, start_timestamp, end_timestamp)", :err_ids => err_objs}, status: :unprocessable_entity }
          end
        end
      end
      
      
      private
      
      def create_trip(trip,user_id)
        return false unless check_required_params(trip)
        trip.delete("trip_id")
        @trip = Trip.new(trip)
        @trip.user_id=user_id
        if @trip.save
          return true
        else
          return false
        end
      end
        
      def restrict_access
        # request with header:
        # authenticate_or_request_with_http_token do |token, options|
        #   ApiKey.where(access_token: token).exists?
        # end
        
        # as url query: e.g http://localhost:3000/api/v1/trips?access_token={api_key}
        unless ApiKey.where(access_token: params[:access_token]).exists? && MobileDevice.where(access_token: params[:access_token]).first.device_id == params[:device_id]
          respond_to do |format| 
            format.json { render json: "Your mobile device's ID doesnt match the ID we have in our records. Please register the mobile device in the Loadmaster Logger web application and try again", status: :unauthorized } 
          end
        end 
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
          :start_comments,
          :end_comments)
      end
      
      def trips_params
        params.require(:trips).permit(:trips)
      end

      def check_required_params(trip)
        if trip.has_key?('trip_id') && trip.has_key?('license_plate') && trip.has_key?('cargo') && trip.has_key?('start_timestamp') && trip.has_key?('end_timestamp')
          if trip.has_key?('start_location') || trip.has_key?('start_address')
            if trip.has_key?('end_location') || trip.has_key?('end_address')
              return true
            end
          end
        end
        return false
      end
    
    end
  
  end
end
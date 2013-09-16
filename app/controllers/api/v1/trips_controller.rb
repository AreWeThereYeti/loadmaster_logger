module Api
  module V1
    
    class TripsController < ApplicationController
      
      skip_before_filter :authenticate_user!
      skip_before_filter :verify_authenticity_token#, :if => Proc.new { |c| c.request.format == 'application/json' }
      before_filter :restrict_access
      
      respond_to :json
      
      # action takes hash of trips and saves them in DB
      def create
        err_objs=[]
        error=false
        user_id=MobileDevice.where(:access_token=>params[:access_token]).first.user_id
        if params.has_key?('trips')
          params[:trips].each do |trip|
            trip_id=trip[1][:trip_id]         #save ref to trip id in case @trip.save fails (used in return response)
            if !create_trip(trip[1],user_id)
              error=true
              err_objs.push(trip_id)
            end
          end
        else
          error=true
        end
        respond_to do |format|
          if !error
            format.json { render json: {:msg => "success"}, status: :created }
          else
            format.json { render json: {:msg => "Could not save the following trips. Please check that all required fields are filled out (license_plate, cargo, start_location, end_location, start_timestamp, end_timestamp)", :err_ids => err_objs}, status: :unprocessable_entity }
          end
        end
      end
      
      
      private
      
      def create_trip(trip,user_id)
        return false unless check_required_params(trip)
        trip.delete("trip_id")
        trip[:start_timestamp]=Time.parse(trip[:start_timestamp])
        trip[:end_timestamp]=Time.parse(trip[:end_timestamp])
        trip[:start_location]=trip[:start_location].split(',')
        trip[:end_location]=trip[:end_location].split(',')
        @trip = Trip.new(trip)
        @trip.user_id=user_id
        if @trip.save
          return true
        else
          return false
        end
      end
        
      def restrict_access
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
        if has_key_and_not_empty(trip,'trip_id') && has_key_and_not_empty(trip,'license_plate') && has_key_and_not_empty(trip,'cargo') && has_key_and_not_empty(trip,'start_timestamp') && has_key_and_not_empty(trip,'end_timestamp')
          if has_key_and_not_empty(trip,'start_location') || has_key_and_not_empty(trip,'start_address')
            if has_key_and_not_empty(trip,'end_location') || has_key_and_not_empty(trip,'end_address')
              return true
            end
          end
        end
        return false
      end
    
    end
  
  end
end
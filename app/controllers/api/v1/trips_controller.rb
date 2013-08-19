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
      
      before_filter :authenticate_user!, except: :index
      
      respond_to :json
      
      def index
        respond_with Trip.all
      end
    
    end
  
  end
end
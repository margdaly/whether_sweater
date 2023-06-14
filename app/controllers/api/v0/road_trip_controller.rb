class Api::V0::RoadTripController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @road_trip = RoadTripFacade.new(params[:origin], params[:destination])
    render json: RoadTripSerializer.new(@road_trip.road_trip)
  end
end

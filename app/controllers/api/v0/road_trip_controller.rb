class Api::V0::RoadTripController < ApplicationController
  def create
    @road_trip = RoadTripFacade.new(params[:origin], params[:destination])
    render json: RoadTripSerializer.new(@road_trip.road_trip)
  end
end

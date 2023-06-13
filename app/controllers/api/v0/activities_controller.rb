class Api::V0::ActivitiesController < ApplicationController
  
  def search
    @activities = ActivitiesFacade.new(params[:destination]).get_activities
    render json: ActivitiesSerializer.new(@activities)
  end
end

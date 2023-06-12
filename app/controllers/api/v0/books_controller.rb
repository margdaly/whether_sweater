class Api::V0::BooksController < ApplicationController
  def index
    # render json: BookSerializer.new(BookFacade.new.get_books(params[:location], params[:quantity]))
    render json: ForecastSerializer.new(ForecastFacade.new.get_forecast(params[:location]))
  end
end
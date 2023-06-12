class Api::V0::BooksController < ApplicationController
  def index
    render json: BookSerializer.new(BookFacade.new.get_city_books(params[:location], params[:quantity]))
    render json: ForecastSerializer.new(ForecastFacade.new.only_current(params[:location]))
  end
end
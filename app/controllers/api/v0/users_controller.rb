class Api::V0::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

  def render_not_found_response(error)
    render json: ErrorSerializer.new(error), status: 404
  end

  def render_invalid_response(error)
    render json: ErrorSerializer.new(error), status: 400
  end

  def create
    user = User.create!(user_params)

    render json: UsersSerializer.new(user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end

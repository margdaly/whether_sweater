class Api::V0::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: ErrorSerializer.new('Invalid credentials, please try again.'), status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end

class Api::V1::Users::SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      error_message = ErrorMessage.new("Invalid login credentials", 401)
      render json: ErrorSerializer.format_error(error_message, 401), status: :unauthorized
    end
  end
end
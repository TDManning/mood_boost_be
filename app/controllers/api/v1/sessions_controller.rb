class Api::V1::SessionsController < ApplicationController
  def create
    if params[:username].blank? || params[:password].blank?
      error_message = ErrorMessage.new("Username and password cannot be blank", 400)
      render json: ErrorSerializer.format_error(error_message), status: :bad_request
    else
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        render json: UserSerializer.new(user)
      else
        error_message = ErrorMessage.new("Invalid login credentials", 401)
        render json: ErrorSerializer.format_error(error_message), status: :unauthorized
      end
    end
  end
end
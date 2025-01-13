class Api::V1::UsersController < ApplicationController

  def index
    users= User.all
    render json: UserSerializer.format_users(User.all)
  end
  
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user.nil?
      render json: ErrorSerializer.format_error(ErrorMessage.new("User not found", 404)), status: :not_found
    elsif user.update(user_params)
      render json: UserSerializer.new(user), status: :ok
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  # def patch
  #  STRETCH GOAL
  # end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :email)
  end
end
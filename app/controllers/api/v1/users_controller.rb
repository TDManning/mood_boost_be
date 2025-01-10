class Api::V1::UsersController < ApplicationController

  def index
    render json: UserSerializer.format_users(User.all)
  end
  
  def create
    user = User.new(user_params)
    render json: UserSerializer.new(user), status: :created
  end

  def update

  end

  private

  def user_params
    params.permit(:username, :password_digest, :first_name, :email)
  end

end
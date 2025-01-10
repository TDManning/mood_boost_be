class Api::V1::UsersController < ApplicationController

  def index
<<<<<<< HEAD
    users= User.all
    render json: UserSerializer.format_user_list(User.all)
=======
    render json: UserSerializer.format_users(User.all)
>>>>>>> 8e7cf68b3af8378286d605b6c9e19d45021dfcbc
  end
  
  def create
    user = User.new(user_params)
<<<<<<< HEAD
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  # def patch

  # end
=======
    render json: UserSerializer.new(user), status: :created
  end

  def update

  end

  private

  def user_params
    params.permit(:username, :password_digest, :first_name, :email)
  end

>>>>>>> 8e7cf68b3af8378286d605b6c9e19d45021dfcbc
end
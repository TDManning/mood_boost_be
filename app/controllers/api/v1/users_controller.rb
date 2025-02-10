class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: UserSerializer.format_users(users)
  end
  
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  def guest_user
    if session[:guest_user_id]
      guest = User.find_by(id: session[:guest_user_id])
      unless guest
        session[:guest_user_id] = nil
        return guest_user
      end
    else
      guest = User.create!(
        username: "guest_#{SecureRandom.hex(4)}",
        email: "#{SecureRandom.hex(4)}@guest.com",
        password: "GuestPass123!"
      )
      session[:guest_user_id] = guest.id
    end
  
    render json: { guest_id: guest.id, username: guest.username }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :email)
  end
  
  def create_guest_user
    User.create!(
      username: "guest_#{SecureRandom.hex(5)}",
      email: "guest_#{SecureRandom.hex(5)}@example.com",
      password: SecureRandom.hex(8)
    )
  end
end

class Api::V1::Users::ActivitiesController < ApplicationController
  def show
    user = User.find_by(id: params[:user_id])
    if user
      activities = user.activities
      render json: { activities: activities }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def create

end

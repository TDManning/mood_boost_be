class Api::V1::Users::ActivitiesController < ApplicationController
  def index
    user = User.find_by(id: params[:user_id])
    if user
      activities = user.activities
      render json: { activities: activities }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def create
    user_activity = UserActivity.create_new_activity(params[:user_id], params[:activity_id])
  
    if user_activity.persisted?
      render json: { user_activity: user_activity }, status: :created
    else
      error_message = "Unable to create activity. Please ensure the user and activity are valid."
      render json: { error: error_message }, status: :unprocessable_entity
    end
  end
end

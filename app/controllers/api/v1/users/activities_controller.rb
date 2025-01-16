class Api::V1::Users::ActivitiesController < ApplicationController
  def index
    activities = UserActivity.get_user_activities(params[:user_id])
    if activities.nil?
      render json: ErrorSerializer.format_error(
        ErrorMessage.new("User not found", :not_found)
      ), status: :not_found
    else
      render json: { activities: activities }, status: :ok
    end
  end

  def create
    user_activity = UserActivity.create_new_activity(params[:user_id], params[:activity_id])
  
    if user_activity.persisted?
      render json: { user_activity: user_activity }, status: :created
    else
      render json: ErrorSerializer.format_error(
        ErrorMessage.new("Unable to create activity. Please ensure the user and activity are valid.", :unprocessable_entity)
      ), status: :unprocessable_entity
    end
  end
end

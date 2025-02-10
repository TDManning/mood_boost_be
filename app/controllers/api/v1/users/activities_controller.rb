class Api::V1::Users::ActivitiesController < ApplicationController
  def index
    user = User.find_by(id: params[:user_id])

    if user.nil?
      return render json: ErrorSerializer.format_error(
        ErrorMessage.new("User not found", :not_found)
      ), status: :not_found
    end

    activities = user.user_activities.includes(:activity).order(created_at: :desc)
    if activities.any?
      activity_data = activities.map do |ua|
        {
          id: ua.id,
          name: ua.activity.name,
          created_at: ua.created_at
        }
      end
      render json: { activities: activity_data }, status: :ok
    else
      render json: ErrorSerializer.format_error(
        ErrorMessage.new("No activities found for this user", :not_found)
      ), status: :not_found
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    
    if user.nil?
      return render json: ErrorSerializer.format_error(
        ErrorMessage.new("User not found", :not_found)
      ), status: :not_found
    end

    activity_name = params[:activity][:name]

    activity = Activity.find_or_create_by(name: activity_name)

    user_activity = UserActivity.create(user: user, activity: activity)

    if user_activity.persisted?
      render json: { user_activity: user_activity }, status: :created
    else
      render json: ErrorSerializer.format_error(
        ErrorMessage.new("Unable to create activity", :unprocessable_entity)
      ), status: :unprocessable_entity
    end
  end
end



class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  def self.get_user_activities(user_id)
    user = User.find_by(id: user_id)
    return nil if user.nil?
    user.activities
  end

  def self.create_new_activity(user_id, activity_id)
    user = User.find_by(id: user_id)
    return UserActivity.new if user.nil?
    create_with_user_and_activity(user.id, activity_id)
  end

  def self.create_with_user_and_activity(user_id, activity_id)
    create(user_id: user_id, activity_id: activity_id)
  end
end

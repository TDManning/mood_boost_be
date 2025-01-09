class UserActivity < ApplicationController
  belongs_to :user
  belongs_to :activity
end
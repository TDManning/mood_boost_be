class Activity < ApplicationController
  has_many :user_activities
  has_many :users, through: :user_activities

  validates :name, presence: true, uniqueness: true
end
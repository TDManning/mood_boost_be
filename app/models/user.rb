class User < ApplicationRecord
  has_many :user_activities, dependent: :destroy
  has_many :activities, through: :user_activities

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, length: { maximum: 20 }, allow_nil: true

  has_secure_password
end
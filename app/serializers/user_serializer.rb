class UserSerializer
  include JSONAPI::Serializer

  attributes :username, :first_name, :email, :created_at, :updated_at

  has_many :user_activities
  has_many :activities, through: :user_activities
end
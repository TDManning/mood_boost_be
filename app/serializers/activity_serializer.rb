class ActivitySerializer
  include JSONAPI::Serializer
  attributes :name, :created_at, :updated_at

  has_many :user_activities
  has_many :users, through: :user_activities
end
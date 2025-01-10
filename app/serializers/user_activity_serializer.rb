class UserActivitySerializer
  include JSONAPI::Serializer

  attributes :created_at, :updated_at

  belongs_to :user
  belongs_to :activity
end
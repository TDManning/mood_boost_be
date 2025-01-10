class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :first_name, :email

  def self.format_user(user)
    { 
      data: {
        id: user.id.to_s,
        type: "user", 
        attributes: {
          username: user.username,
          first_name: user.first_name,
          email: user.email
        }
      }
    }
  end

  def self.format_users(users)
    { 
      data: users.map do |user|
      {
        id: user.id.to_s,
        type: "user", 
        attributes: {
          username: user.username,
          first_name: user.first_name,
          email: user.email
        }
      }
  end
}
end
end

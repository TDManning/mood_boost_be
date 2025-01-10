class UserSerializer
  include JSONAPI::Serializer
  attributes :username, :first_name, :password_digest, :email

  def self.format_user(user)
    { data: 
      {
        id: user[:id]
        type: "user", 
        attributes: {
          username: user[:attributes][:username],
          first_name: user[:attributes][:first_name],
          email: user[:attributes][:email]
        }
      }}
  end



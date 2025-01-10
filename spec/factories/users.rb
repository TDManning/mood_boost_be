FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username }
    password { Faker::Internet.password(min_length: 8) }
    password_digest { BCrypt::Password.create(password) }
    first_name { Faker::Name.first_name }
    email { Faker::Internet.unique.email }
  end
end
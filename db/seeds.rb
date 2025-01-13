# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# default_user = User.create!(username: "default", password_digest: "default", first_name: "default", email: "default@gmail.com")

UserActivity.destroy_all
Activity.destroy_all
User.destroy_all

activity_names = ["View a Joke", "View a Quote", "View Breathing Guide"]

activities = activity_names.map do |activity_name|
  Activity.create!(name: activity_name)
end

# Create a default user with a known password
default_user = User.create!(
  username: "default",
  email: "default@gmail.com",
  first_name: "Default",
  password: "password123"
)

users = [
  { username: "fatima", email: "fatima@example.com", first_name: "Fatima", password: "securepassword1" },
  { username: "meg", email: "meg@example.com", first_name: "Meg", password: "securepassword2" },
  { username: "dominic", email: "dominic@example.com", first_name: "Dominic", password: "securepassword3" },
  { username: "alex", email: "alex@example.com", first_name: "Alex", password: "securepassword4" },
  { username: "jane", email: "jane@example.com", first_name: "Jane", password: "securepassword5" }
].map do |user_data|
  User.create!(user_data)
end

(users + [default_user]).each do |user|
  activities.each do |activity|
    UserActivity.create!(user: user, activity: activity)
  end
end

puts "Seed data created successfully!"
puts "#{User.count} users created."
puts "#{Activity.count} activities created."
puts "#{UserActivity.count} user_activities created."

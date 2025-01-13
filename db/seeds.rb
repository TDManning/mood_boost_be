# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

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
  { username: "apu_nahasapeemapetilon", email: "apu.nahasapeemapetilon@example.com", first_name: "Apu", password: "securepassword1" },
  { username: "ned_flanders", email: "ned.flanders@example.com", first_name: "Ned", password: "securepassword2" },
  { username: "edna_krabappel", email: "edna.krabappel@example.com", first_name: "Edna", password: "securepassword3" },
  { username: "moe_szyslak", email: "moe.szyslak@example.com", first_name: "Moe", password: "securepassword4" },
  { username: "milhouse_van_houten", email: "milhouse.vanhouten@example.com", first_name: "Milhouse", password: "securepassword5" }
].map do |user_data|
  User.create!(user_data)
end

(users + [default_user]).each do |user|
  activities.each do |activity|
    UserActivity.create!(user: user, activity: activity)
  end
end

# Add a user with no activities for edge case testing
user_without_activities = User.create!(
  username: "no_activities",
  email: "no_activities@example.com",
  first_name: "NoActivities",
  password: "password123"
)

puts "Seed data created successfully!"
puts "#{User.count} users created."
puts "#{Activity.count} activities created."
puts "#{UserActivity.count} user_activities created."

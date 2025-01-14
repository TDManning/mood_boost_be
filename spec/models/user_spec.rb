require "rails_helper"

RSpec.describe User, type: :model do
  describe "Relationships:" do
    it {should have_many (:user_activities)}
    it {should have_many(:activities).through :user_activities}
  end
  describe "Validations:" do
    let!(:users) { create_list(:user, 3) }

    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_length_of(:first_name).is_at_most(20).allow_nil }
  end

  describe "password validation" do
    it "ensures the password is securely saved" do
      user = User.create(username: "testuser", email: "test@example.com", password: "password123", password_confirmation: "password123")
      
      expect(user.authenticate("password123")).to be_truthy
      expect(user.password_digest).not_to be_nil
    end

    it "rejects invalid password confirmation" do
      user = User.new(username: "testuser", email: "test@example.com", password: "password123", password_confirmation: "wrongpassword")
      
      expect(user.save).to be_falsey
    end
  end
end
require "rails_helper"

RSpec.describe User, type: :model do
  describe "Relationships:" do
    it {should have_many :user_activities}
    it {should have_many(:activities).through :user_activities}
  end
  describe "Validations:" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
  end
end
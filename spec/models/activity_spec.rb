require "rails_helper"

RSpec.describe Activity, type: :model do
  describe "Validations:" do
    it {should validate_presence_of(:name)}
  end
  describe "Relationships:" do
    it {should have_many :user_activities}
    it {should have_many(:users).through :user_activities}
  end
end
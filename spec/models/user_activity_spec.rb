require "rails_helper"

RSpec.desribe User_Activity, type: model do
  desribe "Relationships" do
    it {should belong_to (:user)}
    it {should belong_to (:activity)}
  end
end
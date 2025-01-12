require 'rails_helper'

RSpec.describe "Activities Endpoints:", type: :request do
  describe "GET #index" do
    let!(:user) { create(:user) }
    let!(:activities) { create_list(:activity, 3, users: [user]) }

    context "when the user exists" do
      it "returns a successful response" do
        get "/api/v1/users/#{user.id}/activities"

        expect(response).to have_http_status(:ok)
      end

      it "returns the correct list of activities for the user" do
        get "/api/v1/users/#{user.id}/activities"

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        activity_ids = activities.map(&:id)

        expect(parsed_response[:activities].map { |activity| activity[:id] }).to match_array(activity_ids)
      end
    end

    context "when the user does not exist" do
      it "returns a 404 status with an error message" do
        get "/api/v1/users/0/activities"

        expect(response).to have_http_status(:not_found)
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:error]).to eq("User not found")
      end
    end
  end
end

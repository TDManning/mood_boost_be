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
        expect(parsed_response[:error]).to eq(nil)
      end
    end
  end

  describe "POST #create" do
  let!(:user) { create(:user) }
  let!(:activity) { create(:activity) }

  context "when the request is valid" do
    it "creates a new UserActivity and returns a 201 status" do
      post "/api/v1/users/#{user.id}/activities", params: { activity_id: activity.id }

      expect(response).to have_http_status(:created)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:user_activity][:user_id]).to eq(user.id)
      expect(parsed_response[:user_activity][:activity_id]).to eq(activity.id)
    end
  end

  context "when the activity is invalid" do
    it "returns a 422 status with an error message" do
      post "/api/v1/users/#{user.id}/activities", params: { activity_id: nil }

      expect(response).to have_http_status(:unprocessable_entity)
      parsed_response = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_response[:errors][0][:detail]).to eq("Unable to create activity. Please ensure the user and activity are valid.")
    end
  end
end
end
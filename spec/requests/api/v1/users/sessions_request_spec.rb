require 'rails_helper'

RSpec.describe Api::V1::Users::SessionsController, type: :controller do
  describe "POST #create" do
    let!(:user) { create(:user, password: "password123") }

    context "when the credentials are valid" do
      it "returns a successful response" do
        post "api/v1/#{user.id}", params: { username: user.username, password: "password123" }

        expect(response).to have_http_status(:ok)
      end

      it "returns the user details in the response" do
        post "api/v1/#{user.id}", params: { username: user.username, password: "password123" }

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:data][:id]).to eq(user.id.to_s)
        expect(parsed_response[:data][:attributes][:username]).to eq(user.username)
      end
    end

    context "when the credentials are invalid" do
      it "returns an unauthorized response with an error message" do
        post "api/v1/#{user.id}", params: { username: user.username, password: "wrongpassword" }

        expect(response).to have_http_status(:unauthorized)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors].first[:detail]).to eq("Invalid login credentials")
      end
    end

    context "when the username does not exist" do
      it "returns an unauthorized response with an error message" do
        post "api/v1/#{user.id}", params: { username: user.username, password: "wrongpassword" }
    
        expect(response).to have_http_status(:unauthorized)
    
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors].first[:detail]).to eq("Invalid login credentials")
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do
  describe "POST #create" do
    let!(:user) { create(:user, password: "password123") }

    context "when the credentials are valid" do
      it "returns a successful response" do
        user_params = { username: user.username, password: "password123" }

        post "/api/v1/sessions", params: user_params.to_json, headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:ok)
      end

      it "returns the user details in the response" do
        user_params = { username: user.username, password: "password123" }

        post "/api/v1/sessions", params: user_params.to_json, headers: { "CONTENT_TYPE" => "application/json" }

        parsed_response = JSON.parse(response.body, symbolize_names: true)

        expect(parsed_response[:data][:id]).to eq(user.id.to_s)
        expect(parsed_response[:data][:attributes][:username]).to eq(user.username)
      end
    end

    context "when the credentials are invalid" do
      it "returns an unauthorized response with an error message" do
        user_params = { username: user.username, password: "wrongpassword" }

        post "/api/v1/sessions", params: user_params.to_json, headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:unauthorized)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors].first[:detail]).to eq("Invalid login credentials")
      end
    end

    context "when the username does not exist" do
      it "returns an unauthorized response with an error message" do
        user_params = { username: "nonexistentuser", password: "password123" }

        post "/api/v1/sessions", params: user_params.to_json, headers: { "CONTENT_TYPE" => "application/json" }

        expect(response).to have_http_status(:unauthorized)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors].first[:detail]).to eq("Invalid login credentials")
      end
    end

    context "when the username or password are empty" do
      it "returns an bad request response with an error message" do
        user_params = { username: "", password: user.password }

        post "/api/v1/sessions", params: user_params.to_json, headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:bad_request)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors].first[:detail]).to eq("Username and password cannot be blank")
      end

      it "returns an bad request response with an error message" do
        user_params = { username: user.username, password: "" }

        post "/api/v1/sessions", params: user_params.to_json, headers: { "CONTENT_TYPE" => "application/json" }
        expect(response).to have_http_status(:bad_request)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors].first[:detail]).to eq("Username and password cannot be blank")
      end
    end
  end
end

require "rails_helper"

RSpec.describe "User Endpoints:", type: :request do 
  describe "GET #index" do
    let!(:users) { create_list(:user, 3) }

    it "returns a list of users" do
      get "/api/v1/users"

      expect(response).to have_http_status(:ok)
      
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:data].length).to eq(3)
    end
  end

  describe "POST #create" do
    context "when the user is valid" do
      let(:valid_attributes) { { user: { username: "newuser", password: "password123", email: "newuser@example.com" } } }

      it "creates a new user and returns a success response" do
        post "/api/v1/users", params: valid_attributes

        expect(response).to have_http_status(:created)
        
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:data][:attributes][:username]).to eq("newuser")
      end
    end

    context "when the user is invalid" do
      let(:invalid_attributes) { { user: { username: "", password: "short", email: "" } } }
    
      it "returns a bad request response with error messages" do
        post "/api/v1/users", params: invalid_attributes
    
        expect(response).to have_http_status(:bad_request)
    
        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:errors]).to be_an(Array)
        expect(parsed_response[:errors].first[:detail]).to match(/can't be blank/)
      end
    end    
  end
end
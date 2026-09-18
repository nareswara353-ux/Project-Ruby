require 'rails_helper'

RSpec.describe "Api::V1::Search", type: :request do
  let!(:course) { create(:course, title: "Ruby on Rails Fundamentals", status: :published) }
  let!(:user) { create(:user, name: "Ruby Master", role: :instructor) }

  describe "GET /api/v1/search" do
    it "returns matching courses and users" do
      get "/api/v1/search", params: { q: "Ruby" }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["courses"]).not_to be_empty
      expect(json["users"]).not_to be_empty
    end

    it "returns empty arrays for blank query" do
      get "/api/v1/search", params: { q: "" }
      json = JSON.parse(response.body)
      expect(json["courses"]).to eq([])
      expect(json["users"]).to eq([])
    end
  end
end

require 'rails_helper'

RSpec.describe "Api::V1::Quizzes", type: :request do
  let(:user) { create(:user, :student) }
  let(:course) { create(:course, status: :published) }
  let!(:quiz) { create(:quiz, course: course, status: :published) }

  let(:auth_headers) { { "Authorization" => "Bearer #{user.api_token}" } }

  describe "GET /api/v1/courses/:course_id/quizzes" do
    it "returns quizzes for course" do
      get "/api/v1/courses/#{course.slug}/quizzes", headers: auth_headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
    end
  end

  describe "GET /api/v1/quizzes/:id" do
    it "returns quiz detail" do
      get "/api/v1/quizzes/#{quiz.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["course_slug"]).to eq(course.slug)
    end
  end
end

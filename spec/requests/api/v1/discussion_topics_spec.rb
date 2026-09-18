require 'rails_helper'

RSpec.describe "Api::V1::DiscussionTopics", type: :request do
  let(:course) { create(:course, status: :published) }
  let!(:topic) { create(:discussion_topic, course: course) }

  describe "GET /api/v1/courses/:course_id/discussion_topics" do
    it "returns discussion topics" do
      get "/api/v1/courses/#{course.slug}/discussion_topics"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
    end
  end

  describe "GET /api/v1/discussion_topics/:id" do
    it "returns topic detail with author" do
      get "/api/v1/discussion_topics/#{topic.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["author"]).to be_present
    end
  end
end

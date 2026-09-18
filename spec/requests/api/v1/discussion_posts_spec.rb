require 'rails_helper'

RSpec.describe "Api::V1::DiscussionPosts", type: :request do
  let(:course) { create(:course, status: :published) }
  let(:topic) { create(:discussion_topic, course: course) }
  let!(:post_record) { create(:discussion_post, discussion_topic: topic) }

  describe "GET /api/v1/discussion_topics/:discussion_topic_id/discussion_posts" do
    it "returns posts for topic" do
      get "/api/v1/discussion_topics/#{topic.id}/discussion_posts"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json.size).to eq(1)
    end
  end

  describe "GET /api/v1/discussion_posts/:id" do
    it "returns post detail" do
      get "/api/v1/discussion_posts/#{post_record.id}"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["author"]).to be_present
    end
  end
end

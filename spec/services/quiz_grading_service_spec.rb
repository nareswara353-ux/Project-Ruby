require 'rails_helper'

RSpec.describe QuizGradingService do
  let(:quiz) { create(:quiz, passing_score: 50) }
  let(:submission) { create(:quiz_submission, quiz: quiz) }
  let(:question) { create(:question, correct_answer: "A") }

  before do
    quiz.quiz_questions.create!(question: question, position: 1, points: 100)
    submission.update!(answers: { question.id.to_s => "A" })
  end

  describe "#call" do
    it "grades submission successfully" do
      result = described_class.new(submission).call
      expect(result.success?).to be true
      expect(result.score).to eq(100)
      expect(result.passed).to be true
    end

    it "updates submission status to graded" do
      described_class.new(submission).call
      expect(submission.reload.status).to eq("graded")
    end

    it "creates notification" do
      expect {
        described_class.new(submission).call
      }.to change(Notification, :count).by(1)
    end
  end
end

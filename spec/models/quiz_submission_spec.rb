require 'rails_helper'

RSpec.describe QuizSubmission, type: :model do
  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(in_progress: 0, completed: 1, graded: 2) }
  end

  describe "#calculate_score" do
    let(:quiz) { create(:quiz) }
    let(:question) { create(:question, correct_answer: "A") }
    let(:submission) { create(:quiz_submission, quiz: quiz) }

    before do
      quiz.quiz_questions.create!(question: question, position: 1, points: 20)
    end

    it "returns score based on correct answers" do
      submission.update!(answers: { question.id.to_s => "A" })
      expect(submission.calculate_score).to eq(20)
    end

    it "returns 0 for wrong answers" do
      submission.update!(answers: { question.id.to_s => "B" })
      expect(submission.calculate_score).to eq(0)
    end
  end
end

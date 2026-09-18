class QuizSubmissionSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      quiz_id: object.quiz_id,
      user_id: object.user_id,
      status: object.status,
      score: object.score,
      passed: object.passed?,
      started_at: object.started_at&.iso8601,
      submitted_at: object.submitted_at&.iso8601
    }
  end
end

class QuizSubmission < ApplicationRecord
  enum status: { in_progress: 0, completed: 1, graded: 2 }

  belongs_to :user
  belongs_to :quiz

  validates :user_id, uniqueness: { scope: :quiz_id }, if: -> { in_progress? }

  before_validation :set_started_at, on: :create

  def total_questions
    quiz.quiz_questions.count
  end

  def answered_questions
    answers.keys.count
  end

  def calculate_score
    return 0 if answers.blank?
    total = 0
    quiz.quiz_questions.each do |qq|
      user_answer = answers[qq.question_id.to_s]
      total += qq.points if qq.correct?(user_answer)
    end
    total
  end

  def grade!
    update(score: calculate_score, status: :graded, submitted_at: Time.current)
  end

  def passed?
    score.to_i >= quiz.passing_score
  end

  private

  def set_started_at
    self.started_at = Time.current
  end
end

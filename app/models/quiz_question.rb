class QuizQuestion < ApplicationRecord
  belongs_to :quiz
  belongs_to :question

  validates :quiz_id, uniqueness: { scope: :question_id }
  validates :position, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :points, presence: true, numericality: { greater_than: 0 }

  before_validation :set_default_position, on: :create

  def correct_answer
    question.correct_answer
  end

  def correct?(answer)
    question.correct?(answer)
  end

  private

  def set_default_position
    self.position = quiz.quiz_questions.maximum(:position).to_i + 1 if position.blank?
  end
end

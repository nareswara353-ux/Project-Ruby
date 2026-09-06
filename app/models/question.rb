class Question < ApplicationRecord
  enum question_type: { multiple_choice: 0, true_false: 1, essay: 2 }
  enum difficulty: { easy: 0, medium: 1, hard: 2 }

  has_many :quiz_questions, dependent: :destroy
  has_many :quizzes, through: :quiz_questions

  validates :content, presence: true, length: { maximum: 1000 }
  validates :correct_answer, presence: true, if: -> { multiple_choice? || true_false? }
  validates :option_a, :option_b, presence: true, if: -> { multiple_choice? }
  validates :option_c, presence: true, if: -> { multiple_choice? && option_c.present? }
  validates :option_d, presence: true, if: -> { multiple_choice? && option_d.present? }
  validates :explanation, length: { maximum: 500 }

  def correct?(answer)
    case question_type
    when "multiple_choice", "true_false"
      answer.to_s.strip == correct_answer.to_s.strip
    when "essay"
      false
    end
  end

  def options
    [option_a, option_b, option_c, option_d].compact
  end
end

class Quiz < ApplicationRecord
  enum status: { draft: 0, published: 1 }

  belongs_to :course
  belongs_to :lesson, optional: true

  has_many :quiz_questions, dependent: :destroy
  has_many :questions, through: :quiz_questions
  has_many :quiz_submissions, dependent: :destroy

  validates :title, presence: true, length: { maximum: 200 }
  validates :time_limit, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :passing_score, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  before_save :update_questions_count

  def total_questions
    questions_count
  end

  def max_score
    questions.sum(:points)
  end

  def randomize_questions!(count = nil)
    available = questions
    available = available.sample(count) if count && count < available.count
    quiz_questions.destroy_all
    available.each_with_index do |q, idx|
      quiz_questions.create(question: q, position: idx + 1)
    end
    update_questions_count
  end

  private

  def update_questions_count
    self.questions_count = quiz_questions.count
  end
end

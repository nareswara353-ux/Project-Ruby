class Certificate < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :code, presence: true, uniqueness: true
  validates :user_id, uniqueness: { scope: :course_id }

  before_validation :generate_code, if: -> { code.blank? }
  before_validation :set_issued_at, if: -> { issued_at.blank? }

  after_create :schedule_pdf_generation

  def valid?
    expires_at.nil? || expires_at > Time.current
  end

  def regenerate!
    generate_code
    update(code: code)
  end

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(16).upcase
  end

  def set_issued_at
    self.issued_at = Time.current
  end

  def schedule_pdf_generation
    GenerateCertificatePdfJob.perform_later(id)
  end
end

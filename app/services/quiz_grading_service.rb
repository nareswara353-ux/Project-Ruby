class QuizGradingService
  Result = Struct.new(:success?, :submission, :score, :passed, :error, keyword_init: true)

  def initialize(submission)
    @submission = submission
  end

  def call
    validate_submission
    score = calculate_score
    passed = score >= submission.quiz.passing_score
    submission.update!(score: score, status: :graded, submitted_at: Time.current)
    notify_result(passed)
    Result.new(success?: true, submission: submission, score: score, passed: passed)
  rescue StandardError => e
    Result.new(success?: false, error: e.message)
  end

  private

  attr_reader :submission

  def validate_submission
    raise "Submission sudah dinilai" if submission.graded?
    raise "Submission belum selesai" if submission.answers.blank?
  end

  def calculate_score
    submission.quiz.quiz_questions.sum do |qq|
      answer = submission.answers[qq.question_id.to_s]
      qq.correct?(answer) ? qq.points : 0
    end
  end

  def notify_result(passed)
    Notification.create!(
      recipient: submission.user,
      notifiable: submission,
      message: passed ? "Selamat! Anda lulus quiz #{submission.quiz.title}" : "Anda belum lulus quiz #{submission.quiz.title}",
      url: "/quiz_submissions/#{submission.id}"
    )
  end
end

class CourseEnrollmentService
  Result = Struct.new(:success?, :enrollment, :error, keyword_init: true)

  def initialize(user:, course:)
    @user = user
    @course = course
  end

  def call
    validate_eligibility
    enrollment = create_enrollment
    notify_user(enrollment)
    Result.new(success?: true, enrollment: enrollment)
  rescue StandardError => e
    Result.new(success?: false, error: e.message)
  end

  private

  attr_reader :user, :course

  def validate_eligibility
    raise "Course tidak tersedia" unless course.published?
    raise "User sudah terdaftar" if Enrollment.exists?(user: user, course: course)
    raise "Course berbayar, silakan lakukan pembayaran" if course.price.positive?
  end

  def create_enrollment
    Enrollment.create!(user: user, course: course, status: :active)
  end

  def notify_user(enrollment)
    Notification.create!(
      recipient: user,
      notifiable: enrollment,
      message: "Berhasil mendaftar di course #{course.title}",
      url: "/courses/#{course.slug}"
    )
    SendEmailNotificationJob.perform_later(user.id, "EnrollmentMailer", "welcome", { course_id: course.id })
  end
end

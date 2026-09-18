class QuizSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      title: object.title,
      description: object.description,
      time_limit: object.time_limit,
      passing_score: object.passing_score,
      status: object.status,
      questions_count: object.questions_count,
      course_slug: object.course.slug
    }
  end
end

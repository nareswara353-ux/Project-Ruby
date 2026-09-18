class CourseSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      title: object.title,
      slug: object.slug,
      description: object.description,
      level: object.level,
      price: object.price.to_f,
      duration: object.duration,
      status: object.status,
      instructor: instructor_payload,
      stats: stats_payload
    }
  end

  private

  def instructor_payload
    { id: object.instructor.id, name: object.instructor.name }
  end

  def stats_payload
    {
      modules_count: object.modules.count,
      lessons_count: object.lessons.count,
      enrollments_count: object.enrollments.count
    }
  end
end

class LessonSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      title: object.title,
      slug: object.slug,
      lesson_type: object.lesson_type,
      duration: object.duration,
      position: object.position,
      status: object.status,
      course_module: module_payload
    }
  end

  private

  def module_payload
    {
      id: object.course_module.id,
      title: object.course_module.title,
      course_slug: object.course_module.course.slug
    }
  end
end

class DiscussionTopicSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      title: object.title,
      content: object.content,
      status: object.status,
      pinned: object.pinned,
      posts_count: object.posts_count,
      course_slug: object.course.slug,
      author: author_payload,
      created_at: object.created_at.iso8601
    }
  end

  private

  def author_payload
    { id: object.user.id, name: object.user.name }
  end
end

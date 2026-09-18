class DiscussionPostSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      content: object.content,
      parent_id: object.parent_id,
      author: author_payload,
      replies_count: object.replies.count,
      created_at: object.created_at.iso8601
    }
  end

  private

  def author_payload
    { id: object.user.id, name: object.user.name }
  end
end

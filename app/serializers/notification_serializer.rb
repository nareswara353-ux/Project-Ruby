class NotificationSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      message: object.message,
      url: object.url,
      read: object.read,
      created_at: object.created_at.iso8601
    }
  end
end

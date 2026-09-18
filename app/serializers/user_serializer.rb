class UserSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      name: object.name,
      role: object.role,
      bio: object.bio,
      created_at: object.created_at.iso8601
    }
  end
end

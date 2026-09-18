class CertificateSerializer < ApplicationSerializer
  def as_json
    {
      id: object.id,
      code: object.code,
      issued_at: object.issued_at.iso8601,
      expires_at: object.expires_at&.iso8601,
      valid: object.active?,
      user: { id: object.user.id, name: object.user.name },
      course: { id: object.course.id, title: object.course.title, slug: object.course.slug }
    }
  end
end

class GenerateCertificatePdfJob < ApplicationJob
  queue_as :critical

  retry_on StandardError, wait: :polynomially_longer, attempts: 5
  discard_on ActiveRecord::RecordNotFound

  def perform(certificate_id)
    certificate = Certificate.find(certificate_id)
    pdf_content = CertificatePdfGenerator.new(certificate).render
    certificate.pdf_url = ActiveStorage::Blob.create_and_upload!(
      io: StringIO.new(pdf_content),
      filename: "certificate-#{certificate.code}.pdf",
      content_type: "application/pdf"
    ).url
    certificate.save!
    Notification.create!(
      recipient: certificate.user,
      notifiable: certificate,
      message: "Sertifikat untuk course #{certificate.course.title} telah tersedia.",
      url: "/certificates/#{certificate.id}"
    )
  end
end

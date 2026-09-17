class CertificatesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:verify]

  def index
    @certificates = current_user.certificates.includes(:course)
  end

  def show
    @certificate = current_user.certificates.find(params[:id])
  end

  def verify
    @certificate = Certificate.find_by!(code: params[:code])
    render :verify
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Sertifikat tidak ditemukan."
  end
end

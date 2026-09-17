require 'rails_helper'

RSpec.describe CourseEnrollmentService do
  let(:user) { create(:user, :student) }
  let(:course) { create(:course, :free, status: :published) }

  describe "#call" do
    context "with valid params" do
      it "creates enrollment successfully" do
        result = described_class.new(user: user, course: course).call
        expect(result.success?).to be true
        expect(result.enrollment).to be_persisted
      end

      it "creates notification for user" do
        expect {
          described_class.new(user: user, course: course).call
        }.to change(Notification, :count).by(1)
      end
    end

    context "when already enrolled" do
      before { create(:enrollment, user: user, course: course) }

      it "returns error" do
        result = described_class.new(user: user, course: course).call
        expect(result.success?).to be false
        expect(result.error).to match(/sudah terdaftar/i)
      end
    end

    context "when course is paid" do
      let(:course) { create(:course, :paid) }

      it "returns error requiring payment" do
        result = described_class.new(user: user, course: course).call
        expect(result.success?).to be false
        expect(result.error).to match(/berbayar/i)
      end
    end
  end
end

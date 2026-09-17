require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:course) }
  end

  describe "validations" do
    subject { build(:enrollment) }

    it { is_expected.to validate_numericality_of(:progress).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
  end

  describe "#complete!" do
    let(:enrollment) { create(:enrollment) }

    it "marks enrollment as completed with full progress" do
      enrollment.complete!
      expect(enrollment.reload.status).to eq("completed")
      expect(enrollment.progress).to eq(100)
      expect(enrollment.completed_at).to be_present
    end
  end

  describe "scopes" do
    let!(:active) { create(:enrollment, status: :active) }
    let!(:completed) { create(:enrollment, :completed) }

    it "returns active enrollments" do
      expect(Enrollment.active).to include(active)
      expect(Enrollment.active).not_to include(completed)
    end

    it "returns completed enrollments" do
      expect(Enrollment.completed).to include(completed)
    end
  end
end

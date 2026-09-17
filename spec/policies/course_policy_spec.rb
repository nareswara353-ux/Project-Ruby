require 'rails_helper'

RSpec.describe CoursePolicy do
  subject { described_class.new(user, course) }

  let(:course) { create(:course, :published) }

  context "as admin" do
    let(:user) { create(:user, :admin) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "as instructor owner" do
    let(:user) { course.instructor }

    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "as student" do
    let(:user) { create(:user, :student) }

    it { is_expected.to permit_action(:show) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:destroy) }
  end
end

require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:course_module) }
    it { is_expected.to have_many(:lesson_completions).dependent(:destroy) }
    it { is_expected.to have_one(:course).through(:course_module) }
  end

  describe "validations" do
    subject { build(:lesson) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:position) }
    it { is_expected.to validate_presence_of(:slug) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(draft: 0, published: 1) }
    it { is_expected.to define_enum_for(:lesson_type).with_values(video: 0, text: 1, quiz: 2) }
  end

  describe "#completed_by?" do
    let(:user) { create(:user, :student) }
    let(:lesson) { create(:lesson) }

    it "returns false when not completed" do
      expect(lesson.completed_by?(user)).to be false
    end

    it "returns true when completed" do
      create(:lesson_completion, user: user, lesson: lesson)
      expect(lesson.completed_by?(user)).to be true
    end
  end
end

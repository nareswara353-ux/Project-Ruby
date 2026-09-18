require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:course_module) }
    it { is_expected.to have_many(:lesson_completions).dependent(:destroy) }
    it { is_expected.to have_one(:course).through(:course_module) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_length_of(:title).is_at_most(200) }
  end

  describe "enums" do
    it { is_expected.to define_enum_for(:status).with_values(draft: 0, published: 1) }
    it { is_expected.to define_enum_for(:lesson_type).with_values(video: 0, text: 1, quiz: 2) }
  end

  describe "auto-position assignment" do
    it "assigns position based on existing lessons" do
      modul = create(:course_module)
      create(:lesson, course_module: modul, position: 1)
      lesson = build(:lesson, course_module: modul, position: nil)
      lesson.valid?
      expect(lesson.position).to eq(2)
    end
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

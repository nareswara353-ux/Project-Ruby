require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:instructor).class_name("User") }
    it { is_expected.to have_many(:modules).class_name("CourseModule").dependent(:destroy) }
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
    it { is_expected.to have_many(:lessons).through(:modules) }
  end

  describe "validations" do
    subject { build(:course) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end

  describe "slug generation" do
    it "auto-generates slug from title" do
      course = build(:course, title: "Ruby on Rails Fundamentals", slug: nil)
      course.valid?
      expect(course.slug).to eq("ruby-on-rails-fundamentals")
    end
  end

  describe "scopes" do
    let!(:published_course) { create(:course, status: :published) }
    let!(:draft_course) { create(:course, status: :draft) }

    it "filters published courses" do
      expect(Course.published).to include(published_course)
      expect(Course.published).not_to include(draft_course)
    end
  end
end

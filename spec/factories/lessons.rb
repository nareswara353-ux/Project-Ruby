FactoryBot.define do
  factory :lesson do
    association :course_module
    title { Faker::Lorem.sentence(word_count: 4) }
    content { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    video_url { "https://example.com/video/#{SecureRandom.hex(4)}" }
    duration { 10 }
    position { 1 }
    status { :published }
    lesson_type { :text }

    trait :video do
      lesson_type { :video }
    end

    trait :draft do
      status { :draft }
    end
  end
end

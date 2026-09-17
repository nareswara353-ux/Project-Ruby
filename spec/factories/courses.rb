FactoryBot.define do
  factory :course do
    association :instructor, factory: [:user, :instructor]
    title { Faker::Educator.course_name }
    description { Faker::Lorem.paragraph(sentence_count: 5) }
    price { [0, 99_000, 149_000].sample }
    status { :published }
    level { :beginner }
    duration { 120 }

    trait :draft do
      status { :draft }
    end

    trait :free do
      price { 0 }
    end

    trait :paid do
      price { 149_000 }
    end
  end
end

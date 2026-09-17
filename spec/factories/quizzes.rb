FactoryBot.define do
  factory :quiz do
    association :course
    title { "Quiz #{Faker::Lorem.sentence(word_count: 3)}" }
    description { Faker::Lorem.paragraph }
    time_limit { 30 }
    passing_score { 70 }
    status { :published }
  end
end

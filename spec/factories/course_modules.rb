FactoryBot.define do
  factory :course_module do
    association :course
    title { "Modul #{Faker::Lorem.sentence(word_count: 3)}" }
    description { Faker::Lorem.paragraph }
    position { 1 }
    status { :published }
  end
end

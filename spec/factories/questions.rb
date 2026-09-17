FactoryBot.define do
  factory :question do
    content { Faker::Lorem.question }
    question_type { :multiple_choice }
    option_a { Faker::Lorem.word }
    option_b { Faker::Lorem.word }
    option_c { Faker::Lorem.word }
    option_d { Faker::Lorem.word }
    correct_answer { %w[A B C D].sample }
    explanation { Faker::Lorem.sentence }
    difficulty { :easy }
    category { Faker::ProgrammingLanguage.name }
  end
end

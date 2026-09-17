FactoryBot.define do
  factory :quiz_submission do
    association :user, factory: [:user, :student]
    association :quiz
    status { :in_progress }
    started_at { Time.current }
    answers { {} }
  end
end

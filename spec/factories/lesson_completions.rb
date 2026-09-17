FactoryBot.define do
  factory :lesson_completion do
    association :user, factory: [:user, :student]
    association :lesson
    completed_at { Time.current }
  end
end

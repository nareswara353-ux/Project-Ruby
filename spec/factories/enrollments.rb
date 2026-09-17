FactoryBot.define do
  factory :enrollment do
    association :user, factory: [:user, :student]
    association :course
    status { :active }
    progress { 0 }
    enrolled_at { Time.current }

    trait :completed do
      status { :completed }
      progress { 100 }
      completed_at { Time.current }
    end

    trait :dropped do
      status { :dropped }
    end
  end
end

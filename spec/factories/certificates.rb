FactoryBot.define do
  factory :certificate do
    association :user, factory: [:user, :student]
    association :course
    code { SecureRandom.alphanumeric(16).upcase }
    issued_at { Time.current }
  end
end

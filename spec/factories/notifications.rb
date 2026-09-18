FactoryBot.define do
  factory :notification do
    association :recipient, factory: :user
    message { Faker::Lorem.sentence }
    url { "/dashboard" }
    read { false }
  end
end

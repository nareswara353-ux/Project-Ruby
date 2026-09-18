FactoryBot.define do
  factory :discussion_post do
    association :discussion_topic
    association :user, factory: [:user, :student]
    content { Faker::Lorem.paragraph }
  end
end

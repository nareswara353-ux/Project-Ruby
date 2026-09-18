FactoryBot.define do
  factory :discussion_topic do
    association :course
    association :user, factory: [:user, :student]
    title { Faker::Lorem.sentence(word_count: 5) }
    content { Faker::Lorem.paragraph }
    status { :open }
    pinned { false }
  end
end

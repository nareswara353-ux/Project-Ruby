FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    password_confirmation { "password123" }
    role { :student }
    confirmed_at { Time.current }
    api_token { SecureRandom.hex(16) }

    trait :admin do
      role { :admin }
    end

    trait :instructor do
      role { :instructor }
      bio { Faker::Lorem.paragraph }
    end

    trait :student do
      role { :student }
    end
  end
end

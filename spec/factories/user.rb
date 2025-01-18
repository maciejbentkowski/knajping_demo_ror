FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "Username#{n}" }
    sequence(:email) { |n| "User#{n}@sample.com" }
    password { "password" }
    role { :user }

    trait :admin do
      role { :admin }
    end

    trait :moderator do
      role { :moderator }
    end

    trait :owner do
      role { :owner }
    end

    factory :admin, traits: [:admin]
    factory :moderator, traits: [:moderator]
    factory :owner, traits: [:owner]
  end
end
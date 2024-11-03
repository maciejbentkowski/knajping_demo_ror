FactoryBot.define do
    factory :user do
        sequence(:username) { |n| "Username#{n}" }
        sequence(:email) { |n| "User#{n}@sample.com" }
        password { "password" }
      end
end

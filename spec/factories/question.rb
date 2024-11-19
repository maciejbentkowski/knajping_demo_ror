FactoryBot.define do
    factory :question do
      sequence(:question) { |n| "Sample question #{n}" }
      association :venue
      association :user
    end
  end

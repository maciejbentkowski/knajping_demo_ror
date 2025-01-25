FactoryBot.define do
    factory :comment do
      sequence(:content) { |n| "Sample comment content #{n}" }
      association :review
      association :user
    end
  end

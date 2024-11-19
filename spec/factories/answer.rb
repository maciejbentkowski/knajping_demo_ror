FactoryBot.define do
    factory :answer do
      sequence(:content) { |n| "Sample answer #{n}" }
      association :question
      association :user
    end
  end

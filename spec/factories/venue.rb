FactoryBot.define do
    factory :venue do
        sequence(:name) { |n| "Venue #{n}" } # ensures unique names like "Venue 1", "Venue 2", etc.

        is_active { true }
        association :user

        transient do
          categories { [] }
        end

        # After creating the venue, associate categories
        after(:create) do |venue, evaluator|
          venue.categories << evaluator.categories if evaluator.categories.any?
        end
    end
  end

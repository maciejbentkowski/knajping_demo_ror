FactoryBot.define do
  factory :venue do
    sequence(:name) { |n| "Venue #{n}" }

    is_active { true }
    association :user

    after(:build) do |venue|
      venue.primary_photo.attach(
        io: StringIO.new('Fake image content'),
        filename: 'test_image.jpg',
        content_type: 'image/jpeg'
      )
    end

    transient do
      categories { [] }
    end

    after(:create) do |venue, evaluator|
      venue.categories << evaluator.categories if evaluator.categories.any?
    end
  end
end

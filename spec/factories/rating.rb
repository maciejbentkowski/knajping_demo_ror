FactoryBot.define do
    factory :rating do
        atmosphere_rating { rand(1..6) }
        availability_rating { rand(1..6) }
        quality_rating { rand(1..6) }
        service_rating { rand(1..6) }
        uniqueness_rating { rand(1..6) }
        value_rating { rand(1..6) }
    end
  end
class Rating < ApplicationRecord
    belongs_to :review

    validates :atmosphere_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :availability_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :quality_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :service_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :uniqueness_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }

    validates :value_rating,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 1..6 }


    validates :review_id, presence: true

    def avg_rating
        ratings = [ atmosphere_rating, availability_rating, quality_rating, service_rating, uniqueness_rating, value_rating ]
        ratings.compact.sum.to_f / ratings.compact.size
      end
end

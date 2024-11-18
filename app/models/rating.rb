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

    after_save :update_review_avg_rating
    after_destroy :update_review_avg_rating


    def avg_rating
        ratings = [ atmosphere_rating, availability_rating, quality_rating, service_rating, uniqueness_rating, value_rating ]
        (ratings.compact.sum.to_f / ratings.compact.size).round(2)
    end

    private

    def update_review_avg_rating
        review.update(avg_rating: avg_rating) if review.present?
    end
end

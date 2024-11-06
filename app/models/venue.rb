class Venue < ApplicationRecord
    belongs_to :user
    has_many :reviews, dependent: :destroy

    has_many :venue_categories
    has_many :categories, through: :venue_categories, dependent: :destroy

    has_many :questions, dependent: :destroy

    has_one_attached :primary_photo
    has_many_attached :photos
    validate :photos_limit


    validates :name, presence: true
    validates :is_active, inclusion: { in: [ true, false ] }
    validates :user_id, presence: true

    scope :active, -> { where(is_active: true) }
    scope :inactive, -> { where(is_active: false) }

    def avg_venue_rating
        total = 0
        self.reviews.each do |review|
            total += review.avg_review_rating
        end
        if self.reviews.count == 0
            0.00
        else
            ((total / self.reviews.count).to_f).round(2)
        end
    end

    def self.most_reviewed
        if ActiveRecord::RecordNotFound
            nil
        else
            venue_id_with_most_reviews = Review.group(:venue_id)
                                               .order("COUNT(venue_id) DESC")
                                               .limit(1)
                                               .count
                                               .keys
                                               .first

            Venue.find_by(id: venue_id_with_most_reviews)
        end
    end

    def self.best_rated_venue
        if ActiveRecord::RecordNotFound
            nil
        else
            venue_id_with_highest_avg_rating = Rating.joins(:review)
                                                     .group("reviews.venue_id")
                                                     .average("(COALESCE(atmosphere_rating, 0) +
                                                                COALESCE(availability_rating, 0) +
                                                                COALESCE(quality_rating, 0) +
                                                                COALESCE(service_rating, 0) +
                                                                COALESCE(uniqueness_rating, 0) +
                                                                COALESCE(value_rating, 0)) / 6.0")
                                                     .max_by { |_, avg| avg }
                                                     &.first
            Venue.find_by(id: venue_id_with_highest_avg_rating)
        end
    end


    private

    def photos_limit
        if photos.attached? && photos.count > 4
          errors.add(:photos, "Mozesz dodać maksymalnie 4 zdjęcia.")
        end
    end
end

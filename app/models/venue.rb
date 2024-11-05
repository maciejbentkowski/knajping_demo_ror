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
        Venue.find_by(id: Review.group(:venue_id).count.max_by { |k, v| v }[0])
    end

    def self.best_rated_venue
        venue_id_with_highest_avg_rating = Rating.joins(:review)
                                                 .group("reviews.venue_id")
                                                 .average("(atmosphere_rating + availability_rating + quality_rating + service_rating + uniqueness_rating + value_rating) / 6.0")
                                                 .max_by { |_, avg| avg }
                                                 &.first
        Venue.find_by(id: venue_id_with_highest_avg_rating)
    end


    private

    def photos_limit
        if photos.attached? && photos.count > 4
          errors.add(:photos, "Mozesz dodać maksymalnie 4 zdjęcia.")
        end
    end
end

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
         reviews.average(:avg_rating)&.round(2) || 0
    end

    def reviews_count
        reviews.size
    end

    def self.most_reviewed_venue
        venue_id_with_most_reviews = Review.group(:venue_id)
                                               .order("COUNT(venue_id) DESC")
                                               .limit(1)
                                               .count
                                               .keys
                                               .first

        return nil unless venue_id_with_most_reviews

        Venue.find_by(id: venue_id_with_most_reviews)
    end

    def self.best_rated_venue
        venue_id_with_best_rating = Review
        .select("venue_id, AVG(reviews.avg_rating) as avg_rating")
        .group(:venue_id)
        .order("avg_rating DESC")
        .first&.venue_id

        return nil unless venue_id_with_best_rating

        Venue.find_by(id: venue_id_with_best_rating)
    end

    def self.search(params)
        params[:query].blank? ? all : where(
            "lower(name) LIKE ?", "%#{sanitize_sql_like((params[:query]).downcase)}%"
        )
    end

    private

    def photos_limit
        if photos.attached? && photos.count > 4
          errors.add(:photos, "Mozesz dodać maksymalnie 4 zdjęcia.")
        end
    end
end

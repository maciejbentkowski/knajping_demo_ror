class Review < ApplicationRecord
    has_one :rating, dependent: :destroy, inverse_of: :review
    belongs_to :user
    belongs_to :venue

    has_many :comments, dependent: :destroy

    accepts_nested_attributes_for :rating

    validates :title, presence: true
    validates :content, presence: true
    validates :user_id, presence: true
    validates :venue_id, presence: true

    validates_associated :rating

    def rating_dictionary
        rating_dictionary = {}
        rating_dictionary["Wartość"] = self.rating.value_rating
        rating_dictionary["Serwis"] = self.rating.service_rating
        rating_dictionary["Atmosfera"] = self.rating.atmosphere_rating
        rating_dictionary["Jakość"] = self.rating.quality_rating
        rating_dictionary["Dostępność"] = self.rating.availability_rating
        rating_dictionary["Unikalność"] = self.rating.uniqueness_rating

        rating_dictionary
    end

    def avg_review_rating
        total = 0
        total += self.rating.atmosphere_rating
        total += self.rating.availability_rating
        total += self.rating.quality_rating
        total += self.rating.service_rating
        total += self.rating.uniqueness_rating
        total += self.rating.value_rating
        (total / 6.0).round(2)
    end
end

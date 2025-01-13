class Comment < ApplicationRecord
    belongs_to :review
    belongs_to :user


    validates :content,
            presence: true,
            length: { maximum: 255 }

    validates :review_id, presence: true
    validates :user_id, presence: true


    def comment_user_avg_rating
        venue = Venue.find(self.review.venue.id)
        user_review_rating = Review.find_by(user_id: self.user.id, venue_id: venue.id)

        if user_review_rating.nil?
            "Brak recenzji"
        else
            user_review_rating.avg_review_rating
        end
    end
end

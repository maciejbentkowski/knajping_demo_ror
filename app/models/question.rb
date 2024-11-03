class Question < ApplicationRecord
    belongs_to :venue
    belongs_to :user
    has_many :answers, dependent: :destroy

    validates :question, presence: true,
            length: { maximum: 255 }
    validates :venue_id, presence: true
    validates :user_id, presence: true
end

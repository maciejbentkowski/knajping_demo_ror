class Answer < ApplicationRecord
    belongs_to :question
    belongs_to :user

    validates :content, presence: true, length: { maximum: 500 }
    validates :question_id, presence: true
    validates :user_id, presence: true
end

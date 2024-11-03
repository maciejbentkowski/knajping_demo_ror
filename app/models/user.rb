class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :venues, dependent: :nullify
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, through: :reviews
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }


  def self.best_reviewer
    user = User.all.max_by { |user| user.reviews.count }
    "#{user.username} with #{user.reviews.count} reviews"
  end
end

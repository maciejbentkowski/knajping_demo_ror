class AddAvgRatingToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :avg_rating, :float
  end
end

class AddVenueIdToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :venue_id, :string
  end
end

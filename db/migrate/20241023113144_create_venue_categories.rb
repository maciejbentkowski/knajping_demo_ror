class CreateVenueCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :venue_categories do |t|
      t.belongs_to :venue, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end

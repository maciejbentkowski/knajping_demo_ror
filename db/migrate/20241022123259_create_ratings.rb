class CreateRatings < ActiveRecord::Migration[8.1]
  def change
    create_table :ratings do |t|
      t.belongs_to :review, index: { unique: true }, foreign_key: true
      t.integer :atmosphere_rating
      t.integer :availability_rating
      t.integer :quality_rating
      t.integer :service_rating
      t.integer :uniqueness_rating
      t.integer :value_rating
      t.timestamps
    end
  end
end

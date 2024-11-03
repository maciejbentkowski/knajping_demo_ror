class CreateVenueQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :venue_questions do |t|
      t.string :question
      t.belongs_to :venue, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

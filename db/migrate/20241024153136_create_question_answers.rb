class CreateQuestionAnswers < ActiveRecord::Migration[8.1]
  def change
    create_table :question_answers do |t|
      t.text :content
      t.references :venue_question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

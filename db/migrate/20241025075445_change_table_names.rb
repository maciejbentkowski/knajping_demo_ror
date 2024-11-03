class ChangeTableNames < ActiveRecord::Migration[8.1]
  def change
    rename_table :question_answers, :answers
    rename_table :review_comments, :comments
    rename_table :venue_questions, :questions
  end
end

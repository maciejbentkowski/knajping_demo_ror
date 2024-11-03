class ChangeColumNames < ActiveRecord::Migration[8.1]
  def change
    rename_column :answers, :venue_question_id, :question_id
  end
end

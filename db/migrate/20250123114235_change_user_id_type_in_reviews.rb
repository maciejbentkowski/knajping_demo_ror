class ChangeUserIdTypeInReviews < ActiveRecord::Migration[8.0]
  def up
    change_column :reviews, :user_id, :integer, using: 'user_id::integer'
  end

  def down
    change_column :reviews, :user_id, :string
  end
end

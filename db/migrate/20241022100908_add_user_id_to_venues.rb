class AddUserIdToVenues < ActiveRecord::Migration[8.1]
  def change
    add_column :venues, :user_id, :string
  end
end

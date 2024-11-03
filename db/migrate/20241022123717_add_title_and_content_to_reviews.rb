class AddTitleAndContentToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :title, :string
    add_column :reviews, :content, :string
  end
end

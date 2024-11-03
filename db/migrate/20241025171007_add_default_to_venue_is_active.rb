class AddDefaultToVenueIsActive < ActiveRecord::Migration[8.1]
  def change
    change_column_default :venues, :is_active, from: nil, to: false
  end
end

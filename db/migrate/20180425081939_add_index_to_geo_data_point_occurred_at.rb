class AddIndexToGeoDataPointOccurredAt < ActiveRecord::Migration[5.1]
  def change
    add_index :geo_data_points, [:user_id, :occurred_at]
    add_index :geo_data_points, [:user_id, :motion]
  end
end

class AddAnomalyToGeodatapoint < ActiveRecord::Migration[5.1]
  def change
    add_column :geo_data_points, :anomaly, :boolean
    add_index :geo_data_points, [:user_id, :anomaly]
  end
end

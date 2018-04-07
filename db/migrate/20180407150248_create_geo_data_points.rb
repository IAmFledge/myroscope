class CreateGeoDataPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :geo_data_points do |t|

      t.belongs_to :user
      t.belongs_to :geo_segment

      t.datetime :occurred_at

      t.st_point :location, geographic: true, has_z: true

      t.string :device_id

      t.integer :speed

      t.integer :horizontal_accuracy
      t.integer :vertical_accuracy

      # [:stationary, :walking, :running, :cycling, :driving]
      t.integer :motion, array: true

      # [:unknown, :unplugged, :charging, :full]
      t.integer :battery_state
      t.integer :battery_level

      t.string :wifi

      t.timestamps
    end
    
    add_index :geo_data_points, :location, using: :gist
  end
end

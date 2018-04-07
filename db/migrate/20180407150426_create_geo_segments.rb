class CreateGeoSegments < ActiveRecord::Migration[5.1]
  def change
    create_table :geo_segments do |t|

      t.belongs_to :user

      t.integer :type # [:motion, :place]

      t.datetime :started_at
      t.datetime :ended_at

      t.integer :duration
      t.integer :steps
      t.integer :calories
      t.integer :distance

      t.integer :battery_usage

      t.timestamps
    end
    add_index :geo_segments, :started_at
    add_index :geo_segments, :ended_at
  end
end

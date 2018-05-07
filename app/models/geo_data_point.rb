class GeoDataPoint < ApplicationRecord
  enum motion: [:stationary, :walking, :running, :cycling, :driving]
  enum battery_state: [:unknown, :unplugged, :charging, :full]

  belongs_to :user
  belongs_to :geo_segment, optional: true

  def self.clustered(points, distance)
    arel_table = self.arel_table
    select(
      arel_table.st_clusterwithin(points, distance)
    )
  end
end

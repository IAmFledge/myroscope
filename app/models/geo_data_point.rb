class GeoDataPoint < ApplicationRecord
  enum motion: [:stationary, :walking, :running, :cycling, :driving]
  enum battery_state: [:unknown, :unplugged, :charging, :full]

  belongs_to :user
  belongs_to :geo_segment
end

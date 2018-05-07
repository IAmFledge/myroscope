class GeoSegment < ApplicationRecord

  ACTIVITIES = [
    :cycling, :running, :walking, :airplane, :boat, :bus, :car, :escalator,
    :ferry, :funicular, :motorcycle, :sailing, :scooter, :train, :tram,
    :transport, :underground, :cross_country_skiing, :downhill_skiing,
    :golfing, :kayaking, :paddling, :paintball, :riding, :roller_skiing,
    :rollerblading, :rollerskating, :rowing, :skateboarding, :skating,
    :snowboarding, :snowshoeing, :soccer, :squash, :stair_climbing, :surfing,
    :swimming, :tennis, :volleyball, :wheel_chair, :windsurfing
  ].freeze

  # enum activity_detected: ACTIVITIES
  enum activity_selected: ACTIVITIES

  enum segment_type: [:motion, :place]

  has_many :geo_data_points
  belongs_to :user

  validates :geo_data_points, length: { minimum: 1 }

  def recalculate
    geos = geo_data_points.all.order(occurred_at: :asc)
    self.started_at = geos.first.occurred_at
    self.ended_at = geos.last.occurred_at
    self.duration = ended_at - started_at
    map_activity
    save!
  end

  def map_activity
     motion = geo_data_points.all.group(:motion).count.max_by{ |k,v| v }[0]
     if motion.present?
       if motion == 'stationary'
         self.type = :place
       elsif motion == 'driving'
         self.activity_selected = 'transport'
         self.type = :motion
       else
         self.activity_selected = motion
         self.type = :motion
       end
     end
  end

end

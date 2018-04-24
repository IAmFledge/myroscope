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
end

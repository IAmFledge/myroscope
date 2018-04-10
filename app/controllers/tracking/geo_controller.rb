module Tracking
  class GeoController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      tracks = JSON.parse request.body.first
      tracks = tracks['locations']

      user = User.first
      geo_segment = GeoSegment.first

      tracks.each do |track|
        ap track
        long = track.dig('geometry', 'coordinates')[0]
        lat = track.dig('geometry', 'coordinates')[1]
        alt = track.dig('properties', 'altitude')
        t = {
          user: user,
          geo_segment: geo_segment,
          occurred_at: track.dig('properties', 'timestamp'),
          device_id: track.dig('properties', 'device_id'),
          speed: track.dig('properties', 'speed'),
          horizontal_accuracy: track.dig('properties', 'horizontal_accuracy'),
          vertical_accuracy: track.dig('properties', 'vertical_accuracy'),
          location: "POINT(#{long} #{lat} #{alt})",
          # motion: track.dig('properties', 'motion').map(&:to_sym),
          battery_state: track.dig('properties', 'battery_state').to_sym,
          battery_level: track.dig('properties', 'battery_level'),
          wifi: track.dig('properties', 'wifi')
        }
        ap t

        point = GeoDataPoint.create!(t)
        break
      end

      render json: { 'result': ENV.fetch('OK_RESPONSE', 'ok') }
    end
  end
end

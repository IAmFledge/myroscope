# Service to parse and manage tracking data points
class TrackingService

  def initialize(params)
    @data = params[:data]
    @user = params[:user]
  end

  def track_geos
    GeoDataPoint.transaction do
      geotracks.each do |track|
        point = GeoDataPoint.create!(geo_data_point_attributes(track))
      end
    end
  end

  private

  attr_reader :data, :user

  def geotracks
    data['locations']
  end

  def geo_data_point_attributes(track)
    {
      user: user,
      occurred_at: track.dig('properties', 'timestamp'),
      device_id: track.dig('properties', 'device_id'),
      speed: track.dig('properties', 'speed'),
      horizontal_accuracy: track.dig('properties', 'horizontal_accuracy'),
      vertical_accuracy: track.dig('properties', 'vertical_accuracy'),
      location: location(track),
      motion: motion(track),
      battery_state: track.dig('properties', 'battery_state').to_sym,
      battery_level: battery_level(track),
      wifi: track.dig('properties', 'wifi')
    }
  end

  def location(track)
    return unless track.dig('geometry', 'coordinates')
    long = track.dig('geometry', 'coordinates')[0]
    lat = track.dig('geometry', 'coordinates')[1]
    alt = track.dig('properties', 'altitude')

    "POINT(#{long} #{lat} #{alt})"
  end

  def motion(track)
    motions = track.dig('properties', 'motion')&.map(&:to_sym)
    return unless motions
    return :driving if motions.include? :driving
    return :walking if motions.include? :walking
    return :cycling if motions.include? :cycling
    return :running if motions.include? :running
    :stationary
  end

  def battery_level(track)
    bl = track.dig('properties', 'battery_level')
    return unless bl
    (bl.to_f * 100).to_i
  end

end

# Service to aggregate data points into segments
class SegmentService

  SEGMENT_TIME_THRESHOLD_SECONDS = 120
  SEGMENT_DISTANCE_THRESHOLD_METERS = 20
  STANDARD_DEVIATION_THRESHOLD = 3

  def initialize(params)
    @user = params[:user]
    @geos = params[:geos]
    @_segments = []
  end

  def segments
    @geos.each do |geo|
      segment = segment_for(geo)
      segment.geo_data_points << geo
      @_segments << segment unless segment == @_segments.last
    end
    @_segments
  end

  private

  attr_reader :_segments, :user

  def segment_for(geo)
    segment = _segments.last
    if segment.blank? || exceeds_segment_thresholds?(geo)
      segment = GeoSegment.new(user: user)
    end
    segment
  end

  def exceeds_segment_thresholds?(geo)
    last_geo = _segments.last.geo_data_points.last
    return true if motion_changed? geo, last_geo
    return true if(
      geo_distance(geo, last_geo) > SEGMENT_DISTANCE_THRESHOLD_METERS &&
      geo_time(geo, last_geo) > SEGMENT_TIME_THRESHOLD_SECONDS
    )
    false
  end

  def motion_changed?(geo, last_geo)
    return false unless last_geo
    if geo.motion.present?
      return true if(
        last_geo &&
        last_geo.motion.present? &&
        last_geo.motion != geo.motion
      )
    end
    false
  end

  def geo_distance(geo, lastgeo)
    return 0 unless lastgeo
    geo.location.distance(lastgeo.location)
  end

  def geo_time(geo, lastgeo)
    return 0 unless lastgeo
    (geo.occurred_at.to_f - lastgeo.occurred_at.to_f).seconds
  end
end

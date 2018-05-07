# Main dashboard when user logs in
class DashboardController < ApplicationController

  def process_segments(segments)
    segments.each do |segment|
      mark_anomalies segment
      valid_geos = segment[:geos].select {|s| s[:anomaly] == false }
      segment[:distance] = valid_geos.map {|s| s[:distance]}.sum
    end
  end

  def mark_anomalies(segment)
    vs = segment[:geos].select { |g| g[:velocity] >= 0 }
    velocities = vs.map {|s| s[:velocity]}
    sum = velocities.sum
    mean = vs.size > 0 ? sum / vs.size : 0
    sv = 0
    if vs.size > 1
      sv = velocities.inject(0){|accum, i| accum +(i-mean)**2 }
      sv = sv/(vs.length - 1).to_f
    end
    sd = Math.sqrt(sv)
    threshold = (mean + sd) * STANDARD_DEVIATION_THRESHOLD
    ap "THRESHOLD #{threshold}"
    segment[:geos].each do |geo|
      geo[:anomaly] = true if geo[:velocity] < 0
      geo[:anomaly] = true if geo[:velocity] > threshold
    end
    segment[:velocity_sd] = sd
    segment[:velocity_mean] = mean
  end

  def segment_for(geo, last_geo, last_segment)
    segment = last_segment
    if segment.blank? || exceeds_segment_thresholds?(geo, last_geo)
      segment = new_segment(geo, last_segment)
    end
    segment
  end

  def exceeds_segment_thresholds?(geo, last_geo)
    if geo[:geo].motion.present?
      return true if(
        last_geo.present? &&
        last_geo[:geo].motion.present? &&
        last_geo[:geo].motion != geo[:geo].motion
      )
      return true if(
        geo[:distance] > SEGMENT_DISTANCE_THRESHOLD_METERS &&
        geo[:time] > SEGMENT_TIME_THRESHOLD_SECONDS
      )
    end
    false
  end


end

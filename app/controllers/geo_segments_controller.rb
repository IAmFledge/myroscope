class GeoSegmentsController < ApplicationController
  before_action :authenticate_user!

  ACTIVITY_COLORS = {
    running: :pink,
    walking: :green,
    cycling: :blue,
    transport: :grey
  }

  def index
    @date = Date.parse(segments_params[:date] || Date.today.to_s)

    @segments = GeoSegment.where(user: current_user).where(
      'ended_at > ? AND started_at < ?',
      @date.to_time.beginning_of_day,
      @date.to_time.end_of_day
    )

    @icons = []
    @routes = []

    @segments.each do |segment|
      next unless segment.segment_type == 'motion'
      @routes << GeoJsonService.new({
        geos: segment.geo_data_points
      }).render_line(ACTIVITY_COLORS[segment.activity_selected.to_sym])
    end
  end

  def show
    @segment = GeoSegment.find_by(user: current_user, id: segments_params[:id])
  end

  def regenerate_day
    @date = Date.parse(segments_params[:date] || Date.today.to_s)

    GeoSegment.where(user: current_user).where(
      'ended_at > ? AND started_at < ?',
      @date.to_time.beginning_of_day,
      @date.to_time.end_of_day
    ).delete_all

    geos = GeoDataPoint.where(
      user: current_user,
      occurred_at: @date.to_time.beginning_of_day...@date.to_time.end_of_day
    ).order(occurred_at: :asc)

    segments = SegmentService.new(
      user: current_user,
      geos: geos
    ).segments

    segments.each do |segment|
      segment.save!
      segment.recalculate
    end

    redirect_to action: :index, date: @date
  end

  private

  def segments_params
    params.permit(:id, :date)
  end
end

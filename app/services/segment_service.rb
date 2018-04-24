# Service to aggregate data points into segments
class SegmentService

  def initialize(params)
    @user = params[:user]
  end

  def assign_segments
    # @datapoints =
    #   GeoDataPoint.where(user: @user, segment: nil).order(:occurred_at)
  end
end

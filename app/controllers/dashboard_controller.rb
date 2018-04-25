# Main dashboard when user logs in
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @date = Date.parse(dashboard_params[:date] || Date.today.to_s)
    @geos = GeoDataPoint.where(
      user: current_user,
      occurred_at: @date.to_time.beginning_of_day...@date.to_time.end_of_day
    ).order(occurred_at: :desc)

    @route = GeoJsonService.new({
      geos: @geos
    }).render_line
  end

  private

  def dashboard_params
    params.permit(:date)
  end
end

# Main dashboard when user logs in
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # GeoDataPoint.delete_all
    @geos = GeoDataPoint.where(user: current_user)
  end
end

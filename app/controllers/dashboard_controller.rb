# Main dashboard when user logs in
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index; end
end

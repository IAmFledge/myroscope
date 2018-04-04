class TrackingController < ApplicationController
  protect_from_forgery with: :null_session

  def index; end

  def create
    ap request.parameters
    # render json: { "result": "ok" }
    render json: {}
  end
end

module Tracking
  class GeoController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      tracks = JSON.parse request.body.first

      TrackingService.new({
        data: tracks,
        user: User.first
      }).track_geos

      render json: { 'result': ENV.fetch('OK_RESPONSE', 'ok') }
    end
  end
end

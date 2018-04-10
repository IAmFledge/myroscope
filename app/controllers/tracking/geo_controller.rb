module Tracking
  class GeoController < ApplicationController
    protect_from_forgery with: :null_session

    def create
      puts request.body.to_json
      render json: {}
    end
  end
end

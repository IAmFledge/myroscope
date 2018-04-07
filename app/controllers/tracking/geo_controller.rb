module Tracking
  class GeoController < ApplicationController
    def create
      puts request.body
      render json: {}
    end
  end
end

# Service to render GeoJson
class GeoJsonService
  def initialize(params)
    @geos = params[:geos]
  end

  def render_line(color = :red)
    line_attributes(color)
  end

  private

  COLORS = {
    red: '#f00',
    pink: '#ff69b4',
    green: '#32cd32',
    blue: '#0ff',
    grey: '#aaa'
  }

  attr_reader :geos

  def line_attributes(color)
    {
      id: (5..300000).to_a.sample.to_s,
      type: 'line',
      source: {
        type: 'geojson',
        data: {
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'LineString',
            coordinates: geo_coords
          }
        }
      },
      layout: {
        'line-join': 'round',
        'line-cap': 'round'
      },
      paint: {
        'line-color': COLORS[color],
        'line-width': 3
      }
    }
  end

  def geo_coords
    coords = []
    geos.each do |geo|
      coords << [geo.location.x, geo.location.y]
    end
    coords
  end
end

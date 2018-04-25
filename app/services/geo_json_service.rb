# Service to render GeoJson
class GeoJsonService
  def initialize(params)
    @geos = params[:geos]
  end

  def render_line
    line_attributes.to_json
  end

  private

  attr_reader :geos

  def line_attributes
    {
      id: 'route',
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
        'line-color': '#0FF',
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

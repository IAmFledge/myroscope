class CreateGeoPlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :geo_places do |t|

      t.belongs_to :user

      t.string :name
      t.string :foursquareId
      t.string :foursquareCategoryIds, array: true

      t.st_point :location, geographic: true

      t.timestamps
    end

    add_index :geo_places, :location, using: :gist
  end
end

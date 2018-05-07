class RenameSegmentType < ActiveRecord::Migration[5.1]
  def change
    rename_column :geo_segments, :type, :segment_type
  end
end

class RenamePlacesToMeasurements < ActiveRecord::Migration
  def change
    rename_table :places, :measurements
  end
end

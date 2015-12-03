class AddFieldsToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :humidity, :float
    add_column :measurements, :place_name, :string
  end
end

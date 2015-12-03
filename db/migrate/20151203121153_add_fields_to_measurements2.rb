class AddFieldsToMeasurements2 < ActiveRecord::Migration
  def change
    add_column :measurements, :status, :string
  end
end

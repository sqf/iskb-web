class AddNewFieldTomovement < ActiveRecord::Migration
  def change
    add_column :movements, :place_name, :string
  end
end

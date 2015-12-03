class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.float :temperature
      t.string :created_at
    end
  end
end

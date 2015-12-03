class AddNewTable < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.datetime :created_at
    end
  end
end

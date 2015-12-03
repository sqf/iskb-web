class ChangeDateFormat < ActiveRecord::Migration
  def up
    change_column :measurements, :created_at, :datetime
  end
  
  def down
    change_column :measurements, :created_at, :string
  end
end

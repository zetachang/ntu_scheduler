class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :schedule_id, :null => false

      t.timestamps
    end
  end
end

class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :schedule_id, :null => false
      t.integer :schedule_set_id, :null => false
      
      t.timestamps
    end
  end
end

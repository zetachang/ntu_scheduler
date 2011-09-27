class CreateScheduleSets < ActiveRecord::Migration
  def change
    create_table :schedule_sets do |t|
      t.integer :permalink_id

      t.timestamps
    end

    add_index :schedule_sets, :permalink_id, :unique => true
  end
end

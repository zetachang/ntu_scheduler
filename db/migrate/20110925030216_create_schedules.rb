class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :user_id, :null => false
      t.integer :schedule_set_id

      t.timestamps
    end
  end
end

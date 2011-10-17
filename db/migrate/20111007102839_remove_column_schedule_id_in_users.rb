class RemoveColumnScheduleIdInUsers < ActiveRecord::Migration
  def change
    remove_column :users, :schedule_id   
  end
end

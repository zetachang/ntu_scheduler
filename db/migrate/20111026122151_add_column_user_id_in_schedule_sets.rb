class AddColumnUserIdInScheduleSets < ActiveRecord::Migration
  def change
    add_column :schedule_sets, :user_id, :integer
    change_column :schedule_sets, :user_id, :integer, :null => false
  end
end

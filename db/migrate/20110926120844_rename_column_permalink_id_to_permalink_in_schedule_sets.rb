class RenameColumnPermalinkIdToPermalinkInScheduleSets < ActiveRecord::Migration
  def change
    remove_index :schedule_sets, :column => :permalink_id
    
    rename_column :schedule_sets, :permalink_id, :permalink
    change_column :schedule_sets, :permalink, :string

    add_index :schedule_sets, :permalink, :unique => true
  end
end

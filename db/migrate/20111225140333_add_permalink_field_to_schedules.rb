class AddPermalinkFieldToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :permalink, :string
    add_index :schedules, :permalink, :unique => true
  end
end

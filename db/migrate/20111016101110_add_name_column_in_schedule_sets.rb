class AddNameColumnInScheduleSets < ActiveRecord::Migration
  def change
    add_column :schedule_sets, :name, :string
  end
end

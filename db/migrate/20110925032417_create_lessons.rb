class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name, :null => false
      t.string :location
      t.integer :time, :null => false
      t.integer :day_id, :null => false

      t.timestamps
    end
  end
end

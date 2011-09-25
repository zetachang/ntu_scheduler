class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :student_id, :null => false
      t.integer :facebook_uid, :limit => 8, :null => false

      t.timestamps
    end

    add_index :users, :facebook_uid, :unique => true
  end
end

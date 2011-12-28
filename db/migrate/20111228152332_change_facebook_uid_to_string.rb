class ChangeFacebookUidToString < ActiveRecord::Migration
  def change
    change_column(:users, :facebook_uid, :string, :limit => 20)
  end
end

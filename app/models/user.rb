class User < ActiveRecord::Base
  has_one :schedule

  validates_presence_of :schedule_id
  validates_presence_of :facebook_uid
  validates_presence_of :username

  validates_uniqueness_of :facebook_uid
end

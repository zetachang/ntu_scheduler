class User < ActiveRecord::Base
  has_one :schedule
  has_many :schedule_sets

  validates_presence_of :name
  validates_presence_of :student_id
  validates_presence_of :facebook_uid

  validates_uniqueness_of :facebook_uid
end

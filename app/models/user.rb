class User < ActiveRecord::Base
  has_one :schedule

  validates_presence_of :name
  validates_presence_of :student_id
  validates_presence_of :facebook_uid

  validates_uniqueness_of :facebook_uid

  after_create { |u| u.schedule = Schedule.create() }
end
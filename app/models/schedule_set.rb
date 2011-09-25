class ScheduleSet < ActiveRecord::Base
  has_many :schedule

  validates_presence_of :permalink_id
  validates_uniqueness_of :permalink_id
end

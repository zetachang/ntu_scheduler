class ScheduleSet < ActiveRecord::Base
  has_many :schedule

  validates_uniqueness_of :permalink_id
end

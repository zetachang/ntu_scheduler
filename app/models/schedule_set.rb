require "securerandom"

class ScheduleSet < ActiveRecord::Base
  has_many :schedule

  validates_uniqueness_of :permalink

  after_create do |ss| 
    begin
      ss.permalink = SecureRandom.hex(3)
    end until ss.save
  end
end

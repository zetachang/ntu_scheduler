require "securerandom"

class ScheduleSet < ActiveRecord::Base
  has_many :schedules, :through => :settings
  has_many :settings
  belongs_to :user

  validates_uniqueness_of :permalink
  validates_presence_of :name

  after_create do |ss| 
    begin
      ss.permalink = SecureRandom.hex(3)
    end until ss.save
  end
end

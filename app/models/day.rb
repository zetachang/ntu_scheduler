class Day < ActiveRecord::Base
  has_many :lessons
  belongs_to :schedule

  validates_presence_of :schedule_id
end

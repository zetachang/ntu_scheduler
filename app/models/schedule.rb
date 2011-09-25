class Schedule < ActiveRecord::Base
  has_many :days
  belongs_to :user
  belongs_to :schedule_set

  validates_presence_of :user_id

  after_create { |s| 6.times { s.days << Day.create } }

end

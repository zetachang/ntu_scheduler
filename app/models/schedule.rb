class Schedule < ActiveRecord::Base
  has_many :days
  belongs_to :user
  belongs_to :schedule_set


end

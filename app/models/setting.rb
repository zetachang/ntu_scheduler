class Setting < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :schedule_set
end

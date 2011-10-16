class Day < ActiveRecord::Base
  has_many :lessons
  belongs_to :schedule
end

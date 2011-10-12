class Lesson < ActiveRecord::Base
  belongs_to :day
  
  validates_presence_of :name
  validates_presence_of :time
end

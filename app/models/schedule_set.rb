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

  def self.create_by_two(schedule_a, schedule_b, user)
    #XXX: it's slow, you know
    @sets_a = ScheduleSet.joins(:schedules).where(:schedules => {:id => schedule_a})
    @sets_b = ScheduleSet.joins(:schedules).where(:schedules => {:id => schedule_b})
    @existed_sets = @sets_a & @sets_b
    
    if @existed_sets.size == 0
      @schedule_set = ScheduleSet.create(:name => "Anonymous Set", :user_id => user)
      @sa = Schedule.find(schedule_a)
      @sb = Schedule.find(schedule_b)
      @schedule_set.schedules << @sa << @sb;
    else
      @schedule_set = @existed_sets.first
    end

    return @schedule_set 
  end

end

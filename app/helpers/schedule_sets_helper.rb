module ScheduleSetsHelper
  def get_info_hash(schedule_set)
    list = schedule_set.schedules
    hash = Array.new(6){Array.new(15){Array.new(0)}}
    list.each do |schedule|
      schedule.days.each_with_index do |day, index| #for every day
        day.lessons.each do |lesson|
          info = {:name => lesson.name,:user => schedule.user,:location => lesson.location}
          hash[index][lesson.time] << info
        end
      end
    end
    hash
  end
end

module SchedulesHelper
  def time_number(time)
    case time
    when 0..4
      time
    when 5
      '@'
    when 6..10
      time-1
    when 11..14
      (time - 11 + 'A'.ord).chr
    end
  end
end

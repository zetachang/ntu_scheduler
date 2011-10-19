class Schedule < ActiveRecord::Base
  has_many :days
  belongs_to :user
  belongs_to :schedule_set

  # probably raise:
  # - ScheduleCrawler::NoPublicError
  # -                  HTTPError
  # -                  NoLessonError
  def load_from_eportfolio(student_id)
    crawler = ScheduleCrawler::NtuCrawler.new(student_id)
    lessons_array = crawler.crawl
    self.days.destroy_all
    (1..6).each{|i| self.days << Day.new}
    lessons_array.each.with_index { |d, i|
      day = self.days[i]
      d.each.with_index { |name, time|
        day.lessons << Lesson.new(:time => time, :name => name) if name.present?
      }
    }
  end

end

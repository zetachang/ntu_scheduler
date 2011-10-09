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
    lessons_array.each.with_index { |d, i|
      day = Day.new()
      self.days << day
      d.each.with_index { |name, time|
        day.lessons << Lesson.new(:time => time, :name => name) if name.present?
      }
    }
  end

end

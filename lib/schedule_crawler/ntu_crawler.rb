require "open-uri"

module ScheduleCrawler
  class NtuCrawler
    def initialize(user)
      @schedule_url = "http://if163.aca.ntu.edu.tw/eportfolio/#{user.student_id.upcase}/schedule.php"
      @user = user
    end

    def crawl
      doc = Nokogiri::HTML(open(@schedule_url))
      parse(doc) 
    end

    private
    def parse(doc)
      schedule = @user.schedule
      grids = doc.css(".class-record")[1].css("td").to_a
      (0..5).each { |d|
        day = schedule.days[d]
        grids.select.with_index { |g,i| i % 6 == d }.each.with_index { |g, time|
          name = g.inner_html
          day.lessons.create(:time => time, :name => name) if name.present?
        }
      }
    end

  end
end

# encoding: UTF-8

require "open-uri"

module ScheduleCrawler
  class NtuCrawler
    def initialize(student_id)
      @schedule_url = "http://if163.aca.ntu.edu.tw/eportfolio/#{student_id.upcase}/schedule.php"
    end

    def crawl
      parse(retrieve)
    end

    private
    def retrieve
      begin
        Nokogiri::HTML(open(@schedule_url))
      rescue OpenURI::HTTPError
        raise HTTPError
      end
    end

    def parse(doc)
      raise NoPublicError if doc.inner_html =~ /此 ePortfolio 設定為不公開/
      lessons_array = Array.new(6, [])
      grids = doc.css(".class-record")[1].css("td").to_a
      (0..5).each { |d|
        grids.select.with_index { |g,i| i % 6 == d }.each { |g|
          lessons_array[d] << g.inner_html
        }
      }
      raise NoLessonError if lessons_array.flatten.empty?
      lessons_array
    end

  end
end

module ScheduleCrawler
  class NoPublicError < StandardError
  end

  class HTTPError < StandardError
  end

  class NoLessonError < StandardError
  end
end

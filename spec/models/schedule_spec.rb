require 'spec_helper'

describe Schedule do
  it { should have_many(:days) }
  it { should belong_to(:user) }

  describe "when ad schedule from eportfolio" do
    before(:each) do
      @schedule = stub_model(Schedule)
      @student_id = "B00902109"
      @lessons_array = Array.new(6) do
        Array.new(15) { [] }
      end
    end

    it "should reraise the error crawler raised" do
      ScheduleCrawler::NtuCrawler.any_instance.stub(:crawl).and_raise("an error")

      expect { @schedule.load_from_eportfolio(@student_id) }.to raise_error("an error")
    end

    it "should new six days if crawler works well" do
      ScheduleCrawler::NtuCrawler.any_instance.stub(:crawl).and_return(@lessons_array)

      @schedule.load_from_eportfolio(@student_id)
      @schedule.days.size.should == 6
    end

    it "should add lessons into day only if the lessos is present" do
      @lessons_array[0][0] = "lesson name"
      ScheduleCrawler::NtuCrawler.any_instance.stub(:crawl).and_return(@lessons_array)

      @schedule.load_from_eportfolio(@student_id)
      @schedule.days[0].lessons.size.should == 1
      @schedule.days[1].lessons.size.should == 0 
    end

  end
end

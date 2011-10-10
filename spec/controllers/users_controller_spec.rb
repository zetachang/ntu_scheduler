#encoding: utf-8

require 'spec_helper'

describe UsersController do
  
  before(:each) do
    session[:graph] = Facebook::TEST_GRAPH
  end

  describe "when create a new user" do 

    it "should reject blank student ID" do
      expected_echo = { "message" => I18n.t("users.no_student_id"),
                        "status" => "ERROR" } 
      ids = ["", "    "]

      ids.each do |id|
        post :create, :user => { :student_id => id }, :format => :json
        echo = JSON.parse(response.body)
        echo.should == expected_echo
      end 
    end
      
    it "should reject illegal student ID" do 
      expected_echo = { "message" => I18n.t("users.illegal_student_id"),
                        "status" => "ERROR" } 
      ids = ["b009021009", "b0090210", "BB0090210", "0b0090210", "abcdefghi"]

      ids.each do |id|
        post :create, :user => { :student_id => id }, :format => :json
        echo = JSON.parse(response.body)
        echo.should == expected_echo
      end 
    end

    describe "when trying to crawl schedule" do

      it "should return proper message when e-portfolio isn't public" do 
        Schedule.any_instance.stub(:load_from_eportfolio).with("B00902109").and_raise(ScheduleCrawler::NoPublicError)
        expected_echo = { "message" => I18n.t("users.no_public"),
                          "status" => "ERROR" }

        post :create, :user => { :student_id => "B00902109" }, :format => :json
        echo = JSON.parse(response.body)
        echo.should == expected_echo
      end

      it "should return proper message when no lesson is found" do 
        Schedule.any_instance.stub(:load_from_eportfolio).with("B00902109").and_raise(ScheduleCrawler::NoLessonError)
        expected_echo = { "message" => I18n.t("users.no_lesson"),
                          "status" => "ERROR" }

        post :create, :user => { :student_id => "B00902109" }, :format => :json
        echo = JSON.parse(response.body)
        echo.should == expected_echo
      end

      it "should return proper message when it can't find e-portfolio page" do 
        Schedule.any_instance.stub(:load_from_eportfolio).with("B00902109").and_raise(ScheduleCrawler::HTTPError)
        expected_echo = { "message" => I18n.t("users.illegal_student_id"),
                          "status" => "ERROR" }

        post :create, :user => { :student_id => "B00902109" }, :format => :json
        echo = JSON.parse(response.body)
        echo.should == expected_echo
      end

      it "should return SUCCESS status if all is right" do
        expected_echo = { "status" => "SUCCESS" }
        Schedule.any_instance.stub(:load_from_eportfolio).with("B00902109")

        expect do
          post :create, :user => { :student_id => "B00902109" }, :format => :json
        end.to change{User.count}.by(1)
        
        echo = JSON.parse(response.body)
        echo.should == expected_echo 

      end

    end
  end
end

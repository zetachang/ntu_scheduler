# encoding: UTF-8

class UsersController < ApplicationController
  def create
    echo = { :status => "ERROR" }

    @user = User.new(params[:user])
    @user.attributes = { :name => @me["name"], :facebook_uid => @me["id"] }
    @user.student_id.upcase!

    if @user.student_id.blank?
      echo[:message] = t("users.no_student_id")
    elsif @user.student_id !~ /^\w\d{8}$/
      echo[:message] = t("users.illegal_student_id")
    else
      @schedule = Schedule.new()
      @user.schedule = @schedule
      begin
        @schedule.load_from_eportfolio(@user.student_id)
      rescue ScheduleCrawler::NoPublicError
        echo[:redirect_url] = show_tutorial_path
        echo[:message] = t("users.no_public")
      rescue ScheduleCrawler::NoLessonError
        echo[:message] = t("users.no_lesson")
      rescue ScheduleCrawler::HTTPError
        echo[:message] = t("users.illegal_student_id")
      else
        @user.save!
        echo[:redirect_url] = main_path
        echo[:status] = "SUCCESS"
      end

    end

    respond_to do |format|
      format.json { render :json => echo.to_json }
    end
  end
end

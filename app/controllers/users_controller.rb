# encoding: UTF-8

class UsersController < ApplicationController
  def create
    respond = { :status => "ERROR" }

    @user = User.new(params[:user])
    @user.update_attributes(:name => @me["name"], :facebook_uid => @me["id"])
    @user.student_id.upcase!

    if @user.student_id.blank?
      respond[:message] = "請填入學號"
    elsif @user.student_id !~ /^\w\d{8}$/
      respond[:message] = "請檢查學號是否正確"
    else

      @schedule = Schedule.new()
      @user.schedule = @schedule
      begin
        @schedule.load_from_eportfolio(@user.student_id)
      rescue ScheduleCrawler::NoPublicError
        # TODO: add a step-by-step tutorial page
        respond[:message] = "請將你的e-portfolio設為公開！"
      rescue ScheduleCrawler::NoLessonError
        respond[:message] = "本學期的課表尚未公佈(或計算機中心正在維修)"
      rescue ScheduleCrawler::HTTPError
        respond[:message] = "請檢查學號是否正確"
      else
        @user.save!
        respond[:status] = "SUCCESS"
      end

    end

    respond_to do |format|
      format.json { render :json => respond.to_json }
    end
  end
end

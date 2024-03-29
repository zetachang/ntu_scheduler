# encoding: utf-8
class SchedulesController < ApplicationController
  skip_before_filter :validate_session, :only => :show

  def show
    @schedule = Schedule.find_by_permalink(params[:id])
    render "show_permalink"
  end

  def show_self
    render :partial => "schedules/show", :locals => {:schedule => current_user.schedule}
  end

  def show_friend
    # Don't need to check whether it in user's friend list because it's harmless
    # Must do the check for privacy consideration
    friend_id = current_friends.find{|id| id == params[:fb_uid]}
    user = User.find_by_facebook_uid(friend_id)
    if user
      if user.schedule
        render :partial => "schedules/show", :locals => {:schedule => user.schedule}
      else
        msg = "看樣子，你的朋友的課表出了點問題。請用右下角的回報按鈕給我們建議，我們會非常感激的 =)"
        render :partial => "shared/alert", :locals => {:msg => msg, :type => "alert"}
      end
    else
      render :partial => "send_invitation", :locals => {:friend_uid => params[:fb_uid]}
    end
  end

  def compare_me
    @schedule_set = ScheduleSet.create_by_two(params[:id], current_user.schedule.id, current_user.id)
    @you = Schedule.find(params[:id]).user
    # Check friendshop before comparing for privacy consideration
    if current_friends.include?(@you.facebook_uid)
      render :partial => 'schedule_sets/compare_show', :locals => {:schedule_set => @schedule_set,:you => @you}
    else
      render :nothing => true, :status => 500 
    end
    #respond_to do |format|
    #  format.json { render :json => {:status => "SUCCESS", :schedule_set => @schedule_set.id } }
    #end
  end

end

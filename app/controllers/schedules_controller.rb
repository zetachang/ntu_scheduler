class SchedulesController < ApplicationController
  def show
  end
  def show_friend
    if current_friends.find{|f| f["id"] == params[:fb_uid]}
      user = User.find_by_facebook_uid(params[:fb_uid])
      if user
        if user.schedule
          render :partial => "schedules/show", :locals => {:schedule => user.schedule}
        else
          msg = "Schedule Unretrieveable."
          render :partial => "shared/alert", :locals => {:msg => msg, :type => "alert"}, :status => :unprocessable_entity
        end
      else
        render :partial => "send_invitation", :status => :unprocessable_entity
      end
    else
      msg = "This person is not on your friends list."
      render :partial => "shared/alert", :locals => {:msg => msg, :type => "info"}, :status => :unprocessable_entity
    end
  end
end

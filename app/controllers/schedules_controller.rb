class SchedulesController < ApplicationController
  def show
    @schedule = Schedule.find_by_permalink(params[:id])
    render "show"
  end

  def show_self
    render :partial => "schedules/show", :locals => {:schedule => current_user.schedule}
  end

  def show_friend
    # Don't need to check whether it in user's friend list because it's harmless
    user = User.find_by_facebook_uid(params[:fb_uid])
    if user
      if user.schedule
        render :partial => "schedules/show", :locals => {:schedule => user.schedule}
      else
        render :partial => "shared/alert", :locals => {:msg => msg, :type => "alert"}
      end
    else
      render :partial => "send_invitation", :locals => {:friend_uid => params[:fb_uid]}
    end
  end
end

#encoding: UTF-8
class ScheduleSetsController < ApplicationController
  def index
    @schedule_sets = current_user.schedule_sets
    render :partial => 'schedule_sets/index', :locals => {:sets => @schedule_sets}
  end

  def destroy 
    @schedule_set = current_user.schedule_sets.find(params[:id])
    @schedule_set.destroy

    respond_to do |format|
      format.json { render :json => {:status => "SUCCESS"} }
    end
  end

  def show
    @schedule_set = current_user.schedule_sets.includes(:schedules => [:user, {:days => :lessons}])
                                              .find(params[:id])
    respond_to do |format|
      format.json { render :partial => "schedule_sets/show", :locals => {:schedule_set => @schedule_set} }
    end
  end

end

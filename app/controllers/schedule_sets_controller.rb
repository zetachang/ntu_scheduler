#encoding: UTF-8
class ScheduleSetsController < ApplicationController
  def index
    @schedule_sets = current_user.schedule_sets
    render :partial => 'schedule_sets/index', :locals => {:sets => @schedule_sets}
  end
  
  #IT'S WRONG, DON'T USE IT
  def create_when_compare
    @a = Schedule.find(params[:schedule_a])
    @b = Schedule.find(params[:schedule_b])
    @existed_sets = ScheduleSets.joins(:settings).where(:settings => {:schedule_id=>@a})
                                .joins(:settings).where(:settings => {:schedule_id=>@b})
    if @existed_sets.size == 0
      @schedule_set = ScheduleSets.create(:name => "Anonymous Set", :user_id => current_user)
      @schedule_set.schedules << a << b;
    else
      @schedule_set = @existed_sets.first
    
    respond_to do |format|
      format.json { render :json => {:status => "SUCCESS", :schedule_set => @schedule.id} }
    end
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

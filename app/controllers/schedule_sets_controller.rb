#encoding: UTF-8
class ScheduleSetsController < ApplicationController
  def index
    @schedule_sets = current_user.schedule_sets
    render :partial => 'schedule_sets/index', :locals => {:sets => @schedule_sets}
  end

  def create_empty
    schedule_set = ScheduleSet.new(:name => params[:name], :user_id => current_user.id)
    if schedule_set.save
      render :json => { :status => "SUCCESS", :id => schedule_set.id, :name => schedule_set.name }
    else
      render :json => { :status => "INVALID", :errors => schedule_set.errors.full_messages }
    end
  end
  
  def create
    #TODO: implement
  end

  def destroy 
    echo = { :status => "ERROR" }

    @schedule_set = current_user.schedule_sets.find(:first, params[:id])
    if @schedule_set.nil?
      echo[:message] << t("schedule_sets.no_schedule_set") 
    else
      @schedule_set.destroy
      echo[:status] = "SUCCESS"
    end
      
    respond_to do |format|
      format.json { render :json => echo }
    end
  end

  def show
    echo = { :status => "ERROR" }

    @schedule_set = current_user.schedule_sets.includes(:schedules => [:user, {:days => :lessons}])
                                              .find(params[:id])
    if @schedule_set.nil?
      echo[:message] << t("schedule_sets.no_schedule_set") 
    else
      echo[:status] = "SUCCESS"
    end
    render :partial => "schedule_sets/show", :locals => {:schedule_set => @schedule_set}
  end

  def add_schedule
    echo = { :status => "ERROR" }

    @schedule_set = current_user.schedule_sets.find(:first, params[:id])
    @schedule = current_user.schedules.find(:first, params[:schedule_id])
    echo.merge! add_schedules_to_specify_schedule_set(@schedule_set, @schedule)

    respond_to do |format|
      format.json { render :json => echo }
    end
  end

  def remove_schedule
    echo = { :status => "ERROR" }

    @schedule_set = current_user.schedule_sets.find(:first, params[:id])
    @schedule = @schedule_set.schedules.find(:first, params[:schedule])
    echo.merge! remove_schedule_from_specify_schedule_set(@schedule_set, @schedule)
      
    respond_to do |format|
      format.json { render :json => echo }
    end
  end

  def add_schedule_to
    echo = { :status => "ERROR" }
    @schedule_set = current_user.schedule_sets.find(params[:schedule_set][:id])
    @schedule = Schedule.find(params[:schedule_id])
    echo.merge! add_schedule_to_specific_schedule_set(@schedule_set, @schedule)
    
    respond_to do |format|
      format.json { render :json => echo }
    end
  end

  def remove_schedule_from 
    echo = { :status => "ERROR" }
    @schedule_set = current_user.schedule_sets.find(params[:schedule_set][:id])
    @schedule = Schedule.find(params[:schedule_id])
    echo.merge! remove_schedule_from_specific_schedule_set(@schedule_set, @schedule)

    respond_to do |format|
      format.json { render :json => echo }
    end
  end

  private
  def add_schedule_to_specific_schedule_set(schedule_set, schedule)
    echo = {}
    #raise schedule.to_yaml
    if schedule_set.nil?
      echo[:message] = t("schedule_sets.no_schedule_set") 
    elsif schedule.nil?
      echo[:message] = t("schedules.no_schedule")
    elsif schedule_set.schedules.include?(schedule)
      echo[:message] = "Already Added"
    else
      schedule_set.schedules << schedule
      echo[:status] = "SUCCESS"
      echo[:message] = "Added"
    end
    return echo
  end

  def remove_schedule_from_specific_schedule_set(schedule_set, schedule)
    echo = {}
    if schedule_set.nil?
      echo[:message] << t("schedule_sets.no_schedule_set") 
    elsif schedule.nil?
      echo[:message] << t("schedules.no_schedule")
    else
      schedule_set.schedules.delete(schedule)
      echo[:status] = "SUCCESS"
    end
    return echo
  end

end

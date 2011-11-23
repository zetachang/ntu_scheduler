#encoding: UTF-8
class ScheduleSetsController < ApplicationController
  def index
    @schedule_sets = current_user.schedule_sets
    render :partial => 'schedule_sets/index', :locals => {:sets => @schedule_sets}
  end

  def create_empty
    schedule_set = ScheduleSet.new(:name => params[:name], :user_id => current_user.id)
    if schedule_set.save
      render :json => schedule_set
    else
      render :nothing => true, :status => :unprocessable_entity
    end
  end
  
  def create
    echo = { :status => "ERROR", :message => []}
    logger.debug params

    @schedule_set = ScheduleSet.new(:name => params[:name], :user_id => current_user) 
    schedule_ids = params[:schedule_ids] ? JSON.parse(params[:schedule_ids]) : []
    schedule_ids.each do |id|
      s = Schedule.find(:first, id)
      if s.nil?
        echo[:message] << t("schedule.no_schedule")
        break;
      end
      @schedule_set.schedules << s
    end
    if @schedule_set.invalid?
      #TODO: i18n attributes
      echo[:message] = echo[:message] | @schedule_set.errors.to_a
    else
      @schedule_set.save!
      echo[:status] = "SUCCESS"
    end

    respond_to do |format|
      format.json { render :json => echo }
    end
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

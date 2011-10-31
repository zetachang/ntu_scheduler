#encoding: UTF-8
class ScheduleSetsController < ApplicationController
  def create
    if request.xhr?
      set_name_list = [['國文作業','1'],['社團朋友','2'],['新的list','3'],['Create New Set','0']]
      render :json => set_name_list
    else
      redirect_to :controller => 'main' , :action => 'index'
    end
  end
end

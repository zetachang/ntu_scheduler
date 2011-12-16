class MainController < ApplicationController
  def index
    @schedule = current_user.schedule
    @sets = current_user.schedule_sets
  end
  
  def friends
    #query = params[:q].strip.downcase
    friends = @graph.get_connections("me", "friends")
    arr = friends.map{|f| {:value => f['name'], :id => f['id']} }
    render :json => arr
  end
end

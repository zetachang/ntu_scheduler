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
  
  def friends_index
    @friends = User.where(:facebook_uid => current_friends)
    render :partial => 'main/friends_index', :locals => {:friends => @friends}
  end
end

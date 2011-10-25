class MainController < ApplicationController
  def index
    @user = User.includes(:schedule => {:days => :lessons})
                .find_by_facebook_uid(@me["id"])
    @schedule = @user.schedule
  end
  
  def friends
    #query = params[:q].strip.downcase
    friends = @graph.get_connections("me", "friends")
    arr = friends.map{|f| {:value => f['name'], :id => f['id']} }
    render :json => arr
  end
end

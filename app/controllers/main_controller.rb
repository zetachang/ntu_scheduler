class MainController < ApplicationController
  def index
    @user = User.includes(:schedule => {:days => :lessons})
                .find_by_facebook_uid(@me["id"])
  end
  
  def friends
    #query = params[:q].strip.downcase
    friends = @graph.get_connections("me", "friends")
    arr = friends.map{|f| f['name']}
    render :json => arr
  end
end

class MainController < ApplicationController
  def index
  end
  
  def friends
    #query = params[:q].strip.downcase
    friends = @graph.get_connections("me", "friends")
    arr = friends.map{|f| f['name']}
    render :json => arr
  end
end

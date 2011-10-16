class MainController < ApplicationController
  def index
    @user = User.includes(:schedule => {:days => :lessons})
                .find_by_facebook_uid(@me["id"])
  end
end

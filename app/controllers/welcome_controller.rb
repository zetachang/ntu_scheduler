class WelcomeController < ApplicationController
  skip_before_filter :validate_session
  before_filter :validate_facebook

  def index
    if current_user
      redirect_to main_path
    else
      render
    end
  end
  
  def show_tutorial
  end
  
  def validate_facebook
    if params[:signed_request]
      @oauth = Koala::Facebook::OAuth.new
      signed_request = @oauth.parse_signed_request(params[:signed_request])
      if signed_request["oauth_token"] 
        graph = Koala::Facebook::GraphAPI.new(signed_request["oauth_token"])
        session[:graph] = graph
        validate_session
      else
        # if user hasn't authorized this app, make him do it
        oauth_dialog
      end
    else 
      unless request.headers['User-Agent'] =~ /facebook/
        validate_session
      end
    end
  end
end

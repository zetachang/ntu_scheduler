class WelcomeController < ApplicationController
  skip_before_filter :validate_session
  before_filter :validate_facebook

  def index
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
      validate_session
    end
  end
end

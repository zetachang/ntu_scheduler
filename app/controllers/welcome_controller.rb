class WelcomeController < ApplicationController
  skip_before_filter :validate_session
  before_filter :validate_facebook

  def index
  end

  def oauth_dialog
    top_redirect_to @oauth.url_for_oauth_code
  end

  def validate_facebook
    # if it's running outside Facebook, render 404 page
    raise ActionController::RoutingError, "run outside Facebook" unless params[:signed_request]

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
  end
end

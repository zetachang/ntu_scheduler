class WelcomeController < ApplicationController
  def index
    @oauth = Koala::Facebook::OAuth.new
    unless @signed_request["user_id"]
      render :text => "<script> top.location.href = '#{@oauth.url_for_oauth_code}'; </script>"
    end
  end
end

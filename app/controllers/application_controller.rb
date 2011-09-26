require "facebook_exception"

class ApplicationController < ActionController::Base
  rescue_from FacebookException::SessionError, :with => :oauth_dialog
  before_filter :validate_session

  protect_from_forgery

  def top_redirect_to(url)
    render :text => "<script> top.location.href = '#{url}'; </script>"
  end

  def oauth_dialog
    top_redirect_to Koala::Facebook::OAuth.new.url_for_oauth_code
  end

  def validate_session
    raise FacebookException::SessionError unless session[:graph]
    @graph = session[:graph]
    begin
      @me = @graph.get_object("me")
    rescue
      raise FacebookException::SessionError
    end
  end

end

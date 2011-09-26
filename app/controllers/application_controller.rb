require "facebook_exception"

class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, :with => :render_404
  rescue_from FacebookException::SessionError, :with => :top_reload
  before_filter :validate_session

  protect_from_forgery

  def render_404(message = "page not found")
    logger.info "Render 404 because: #{message}"
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false 
  end

  def top_reload
    render :text => "<script> top.location.reload(); </script>"
  end

  def top_redirect_to(url)
    render :text => "<script> top.location.href = '#{url}'; </script>"
  end

  def validate_session
    raise FacebookException::SessionError unless session[:graph]
    @graph = session[:graph]
    @me = @graph.get_object("me")
  end

end

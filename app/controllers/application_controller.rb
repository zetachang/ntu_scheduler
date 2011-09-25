class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError, :with => :render_404

  protect_from_forgery

  before_filter :validate_facebook

  def render_404(message = "page not found")
    logger.info "Render 404 because: #{message}"
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false 
  end

  def validate_facebook
    # if it's running outside Facebook, render 404 page
    raise ActionController::RoutingError, "run outside Facebook" unless params[:signed_request]

    @oauth = Koala::Facebook::OAuth.new
    @signed_request = @oauth.parse_signed_request(params[:signed_request])
    if @signed_request["user_id"]
      @graph = Koala::Facebook::GraphAPI.new(@signed_request["oauth_token"])
    else
      # if user hasn't authorized this app, make him do it
      render :text => "<script> top.location.href = '#{@oauth.url_for_oauth_code}'; </script>"
    end
  end
end

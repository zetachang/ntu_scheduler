class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :parse_signed_request 

  helper_method :signed_request 
  
  def render_404(message = "Not Found")
    logger.info "Render 404 because: #{message}"
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false 
  end

  def signed_request 
    @signed_request 
  end 

  def parse_signed_request 
    if params[:signed_request]
      @signed_request = Koala::Facebook::OAuth.new.parse_signed_request(params[:signed_request])
    else
      render_404("run outside of Facebook") unless params[:signed_request]
    end
  end
end

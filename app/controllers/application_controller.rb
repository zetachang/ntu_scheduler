class ApplicationController < ActionController::Base
  rescue_from Exception, :with => :unknown_error if Rails.env.production?
  before_filter :set_p3p,:validate_session

  protect_from_forgery

  def top_redirect_to(url)
    render :text => "<script> top.location.href = '#{url}'; </script>"
  end

  def oauth_dialog
    top_redirect_to Koala::Facebook::OAuth.new.url_for_oauth_code(:permissions => Facebook::PERMISSIONS)
  end

  def unknown_error
    if $!.kind_of?(ActionView::TemplateError)
      logger.error $!.original_exception.class.to_s
      logger.error $!.source_extract
    end
    logger.error $!.message
    logger.error $!.backtrace.join("\n")
    respond_to do |format|
      format.html { oauth_dialog }
      format.js { render :nothing => true, :status =>  500 }
      format.json { render :nothing => true, :status => 500 }
    end
  end

  def set_p3p
    response.headers["P3P"]='CP="CAO PSA OUR"'
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
  
  def current_user
    if @me
      @current_user ||= User.includes(:schedule => {:days => :lessons}).find_by_facebook_uid(@me["id"].to_s)
    end
  end
  
  def current_friends
    @current_friends ||= @graph.get_connections("me", "friends").map{|f| f["id"]}
  end

end

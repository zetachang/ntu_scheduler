module ApplicationHelper
  def current_user
    @current_user ||= User.includes(:schedule => {:days => :lessons}).find_by_facebook_uid(@me["id"])
  end
  
  def square_profile(user, options = {})
    fb_url = "http://graph.facebook.com/%s/picture?type=square"
    image_tag(fb_url % user.facebook_uid, options)
  end
end

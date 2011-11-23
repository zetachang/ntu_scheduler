module ApplicationHelper
  def current_user
    @current_user ||= User.includes(:schedule => {:days => :lessons}).find_by_facebook_uid(@me["id"])
  end
end

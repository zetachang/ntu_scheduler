# config/initializers/koala.rb
# Monkey-patch in Facebook config so Koala knows to 
# automatically use Facebook settings from here if none are given

module Facebook
  CONFIG = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]
  APP_ID = CONFIG['app_id']
  SECRET = ENV['facebook_key']
  CALLBACK_URL = CONFIG['callback_url']
  PERMISSIONS = CONFIG['permissions']
  if Rails.env.test?
    test_users = Koala::Facebook::TestUsers.new(:app_id => APP_ID, :secret => SECRET)
    test_user = test_users.list[0] || test_users.create(true, PERMISSIONS)
    TEST_GRAPH = Koala::Facebook::GraphAPI.new(test_user['access_token'])
  end
end

Koala::Facebook::OAuth.class_eval do
  def initialize_with_default_settings(*args)
    case args.size
    when 0, 1
      raise "application id and/or secret are not specified in the config" unless Facebook::APP_ID && Facebook::SECRET
      initialize_without_default_settings(Facebook::APP_ID.to_s, Facebook::SECRET.to_s, Facebook::CALLBACK_URL.to_s)
    when 2, 3
      initialize_without_default_settings(*args) 
    end
  end 

  alias_method_chain :initialize, :default_settings 
end

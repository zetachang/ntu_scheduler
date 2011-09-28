source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'koala', '~> 1.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'haml-rails', "~> 0.3.4"
  gem "compass", "~> 0.12.alpha"
  gem 'bootstrap-sass', '1.3.0'
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'watchr'
  gem 'shoulda-matchers'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'factory_girl_rails'
end

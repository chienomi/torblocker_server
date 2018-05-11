source 'https://rubygems.org'
gem 'rails','~> 4.2.5'
gem 'rake', '~> 10.5.0'
gem 'rb-readline'

# app server
gem 'unicorn'
gem 'thin', group: :development
# gem 'redis', '3.0.6'

# DB
gem 'pg', '~> 0.18'
gem 'pg_search'
gem "google-cloud"
gem "google-cloud-error_reporting"

# statics
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails' # required for websockets
gem 'bootstrap-sass' # required
gem 'uglifier','>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'execjs'
gem 'gon','~> 6.0'

# login flow
gem 'devise'
gem 'stripe'
gem 'omniauth-stripe-connect'#, '~> 2.9'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"

# auxiliary gems
gem 'aws-sdk','< 2.0'
gem 'aws-sdk-s3'
gem 'paperclip', '~> 5.2.0.'
gem 'jquery-turbolinks','~> 2.1'
gem 'will_paginate','~> 3.1'
gem 'will_paginate-bootstrap','~> 1.0'
gem 'friendly_id','~> 5.1.0'
gem 'open_uri_redirections'
gem 'certified'
gem 'addressable', require: 'addressable/uri'
gem 'http_accept_language'

# crontab scheduling
gem 'whenever', require: false

# For Windows support
gem "tzinfo-data"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
gem 'byebug'

gem 'capistrano','3.4.0'
  # rails specific capistrano funcitons
gem 'capistrano-rails','~> 1.1.1'
# integrate bundler with capistrano
gem 'capistrano-bundler','~> 1.1.2'
# if you are using RBENV
gem 'capistrano-rvm', github: "capistrano/rvm"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console','~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test, :development do
  "rspec-rails"
end

group :test do
  gem "capybara"
end

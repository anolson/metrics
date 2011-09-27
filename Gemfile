source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'prototype-rails'

group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
end

gem 'strava-api', :git => 'git://github.com/anolson/strava-api.git'
gem 'joule'

group :development, :test do
  gem 'mocha', :require => nil
end

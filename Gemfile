source 'http://rubygems.org/'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
require 'rubygems'

gem 'rails', '4.0.0'
#gem "mongo", "~> 1.9.2"
#gem "mongo_mapper"

gem 'mongoid', github: 'mongoid/mongoid'
gem 'mongoid_search'
#gem "bson", "~> 1.9.2"
#gem 'bson_ext'
#gem "bcrypt-ruby", :require => "bcrypt"

# Use SCSS for stylesheets
#gem 'sass-rails', '~> 4.0.0.rc1'

gem 'execjs'
gem "therubyracer"

# Use LESS for stylesheets
gem "less-rails"
gem 'sass-rails'


# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-turbolinks'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Include twitter bootstrap 3.0.0rc1
gem 'bootstrap-rails-engine'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

gem 'devise', '3.0.0.rc'
gem 'cancan', '~> 1.6.10'

#pagination
gem 'kaminari'

#pdf generation
gem 'time_diff'

# group :production do
#   gem "wkhtmltopdf-heroku"
# end
# 
# group :development do
#   gem 'wkhtmltopdf-binary'
# end

#gem "wkhtmltopdf"
gem 'wicked_pdf'
gem "wkhtmltopdf-binary"

#gem 'loadmaster_assets', :path => "../loadmasterlogger_Tablet/www/src/loadmaster_assets"
gem 'loadmaster_assets', :git => 'git@github.com:AreWeThereYeti/loadmaster_assets.git'

group :assets do
  gem 'less'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
group :development do
  gem "capistrano-rails"
end

gem 'capistrano-passenger'
gem 'capistrano-rvm'
gem 'capistrano-bundler'
#gem 'capistrano', '~> 3.1.0'

#gem 'capistrano-rails', '~> 1.1.1'

# Use debugger
# gem 'debugger', group: [:development, :test]

source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'bcrypt-ruby', '~> 3.0.1'
gem 'will_paginate', '~> 3.0.3'
gem 'jquery-rails', '~> 2.0.2'
gem 'faker'  # generate fake data into database

# add on 5/5/13
gem 'newrelic_rpm'
# gem 'kaminari'
# gem 'mysql2', '~> 0.3.11'

# Gems used only for assets and not required
# in production environments by default.

group :production do
 # gems specifically for Heroku go here
  gem 'pg'
  gem 'thin'
end

group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier',     '1.2.3'
end

group :development, :test do
  gem 'mysql2', '~> 0.3.11'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
  gem 'rb-fsevent', '0.9.1', :require => false # guard dependency
  gem 'growl', '1.0.3'
  #gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '~> 1.4.0'
  gem 'launchy', '~> 2.0.5'
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

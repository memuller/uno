source 'http://rubygems.org'

gem 'rails', '3.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

#gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'mongoid', :git => 'https://github.com/mongoid/mongoid.git'
gem 'bson_ext'
gem 'bcrypt-ruby', :require => 'bcrypt'

gem 'haml'
gem "haml-rails"

gem 'autotest'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'machinist', '>= 2.0.0.beta1'
  gem 'rspec-rails', "~> 2.0.1"
  #gem 'machinist_mongo'
  gem 'machinist_mongo', :git => 'https://github.com/nmerouze/machinist_mongo.git', :branch => 'machinist2', :require => 'machinist/mongoid'
end

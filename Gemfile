source 'http://rubygems.org'

gem 'rails', '3.0.1'
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Activerecord needs this. We don't need activerecord, but...
#gem 'sqlite3-ruby', :require => 'sqlite3'

# Mongo stuff
gem 'mongoid', :git => 'https://github.com/mongoid/mongoid.git'
gem 'bson_ext'

# Password hasher
gem 'bcrypt-ruby', :require => 'bcrypt'

# Don't need this guy anymore, since we're using UnoStore
#gem "mongoid_session_store"

# Haml. I wonder why it's not working without haml-rails?
gem 'haml'
gem "haml-rails"

# Autotest is awesome
gem 'autotest'

# Mongrel
#gem 'mongrel', '>=1.2.0.pre2'
# Thin
gem 'thin'

group :development, :test do
  # Machinist2 and machinist-mongo. Do not unlock those versions
  gem 'machinist', '>= 2.0.0.beta1'
  gem 'machinist_mongo', :git => 'https://github.com/nmerouze/machinist_mongo.git', :branch => 'machinist2', :require => 'machinist/mongoid'

  # Good old rspec for Rails 3
  gem 'rspec-rails', "~> 2.0.1"

  # Debugger for ruby servers on 1.9 or 1.8
  gem 'ruby-debug19', :platforms => :ruby_19
  gem 'ruby-debug', :platforms => :ruby_18

  # Integration/acceptance tests
  gem 'steak', '>= 1.0.0.rc.1'
  gem 'capybara'

end

source 'https://rubygems.org'

gem 'jquery-rails'
gem 'rails', '3.2.11'
gem 'haml-rails'
gem 'devise'
gem "geocoder"
gem "rmagick"
gem "carrierwave"
gem 'thin'
gem 'stripe'
gem 'newrelic_rpm'

group :production do
  gem 'pg'
  gem 'redis', '3.0.2'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'shoulda'
  gem 'pg'
  gem 'redis', '3.0.2'
  gem "rspec-rails", "~> 2.0"
  gem "factory_girl_rails", "~> 4.0"
end

group :development do
  gem 'pry-rails'
  gem 'pry'
end

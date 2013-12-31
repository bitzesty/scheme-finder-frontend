source 'https://rubygems.org'

gem 'rails', '4.0.2'

gem "foreman"
gem "dotenv-rails"
gem "hipchat", "~> 1.0.1"
gem "airbrake", github: "viperdezigns/airbrake", branch: "capistrano3"

gem 'unicorn'

gem "bootstrap-sass", ">= 3.0.0.0"
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

gem "slim-rails"
gem "simple_form", "~> 3.0.0"

gem "decent_exposure", "~>2.3.0"
gem "active_hash", ">= 1.2.2"
gem "virtus"

gem "carrierwave"
gem "mini_magick"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem 'capistrano-rails', '~> 1.1.0'
end

group :test do
  gem "capybara"
  gem "factory_girl_rails"
end

group :development, :test do
  gem "quiet_assets"
  gem "forgery"
  gem "pry-rails"
  gem "byebug"
  gem "rspec-rails", "~> 2.14.0"
end

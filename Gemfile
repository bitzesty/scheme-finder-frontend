source 'https://rubygems.org'
source 'https://BnrJb6FZyzspBboNJzYZ@gem.fury.io/govuk/'

gem 'rails', '4.0.2'

gem "foreman"
gem "dotenv-rails"
gem "hipchat", "~> 1.0.1"
gem "airbrake", github: "viperdezigns/airbrake", branch: "capistrano3"

gem 'unicorn'

gem "govuk_template"
gem "bootstrap-sass", ">= 3.0.0.0"
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'

gem "slim-rails"
gem "simple_form", "~> 3.0.0"

gem "httparty"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem 'capistrano-rails', '~> 1.1.0'
end

group :test do
  gem "capybara"
  gem "factory_girl_rails"
  gem "webmock"
  gem "vcr"
end

group :development, :test do
  gem "quiet_assets"
  gem "forgery"
  gem "pry-rails"
  gem "byebug"
  gem "rspec-rails", "~> 2.14.0"
end

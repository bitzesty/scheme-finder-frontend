source 'https://rubygems.org'
source 'https://BnrJb6FZyzspBboNJzYZ@gem.fury.io/govuk/'

gem 'rails', '4.0.5'

gem "foreman"
gem "dotenv-rails"

gem "sentry-raven",
    git: "https://github.com/getsentry/raven-ruby.git"

gem 'passenger'

gem "govuk_template",
    git: "git://github.com/bitzesty/govuk_template.git",
    branch: "compiled-assets"
gem "bootstrap-sass", ">= 3.0.0.0"
gem 'sass-rails', '~> 4.0.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem "select2-rails", "3.4.7"

gem "slim-rails"
gem "simple_form", "~> 3.0.0"
gem "kaminari"

gem "faraday"
gem "faraday_middleware"
gem "virtus"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'slackistrano', require: false
end

group :test do
  gem "capybara"
  gem "capybara-webkit"
  gem "factory_girl_rails"
  gem "launchy"
end

group :development, :test do
  gem "quiet_assets"
  gem "forgery"
  gem "pry-rails"
  gem "byebug"
  gem "rspec-rails", "~> 2.14.0"
end

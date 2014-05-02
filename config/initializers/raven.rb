require 'raven'

Raven.configure do |config|
  config.dsn = ENV['GETSENTRY']
end
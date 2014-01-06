ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
# require "webmock/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[
  Rails.root.join('spec/features/steps/*.rb'),
  Rails.root.join('spec/features/steps/**/*.rb')
].each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include ApiClientHelper
  config.include FactoryGirl::Syntax::Methods
  config.include ExpectationHelpers
  config.include FeaturesHelpers, type: :feature
  config.include SelectHelper, type: :feature
end

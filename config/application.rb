require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module SchemeFinderFrontend
  class Application < Rails::Application
    require 'scheme_finder_frontend'

    config.generators do |g|
      g.template_engine :slim
      g.test_framework :rspec,
                       fixture: true,
                       routing_specs: false,
                       helper_specs: false,
                       request_specs: false,
                       decorator_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs false
      g.helper_specs false
      g.controller_specs false
      g.jbuilder false
      g.stylesheets false
      g.assets false
      g.helper false
      g.javascripts false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.assets.precompile += %w(
      application.css
      application-ie9.css
      application-ie8.css
      application-ie7.css
      application-ie6.css
      application.js
    )

    config.i18n.enforce_available_locales = true
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end

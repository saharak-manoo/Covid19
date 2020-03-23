require_relative 'boot'
require "active_storage/engine"

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Covid19
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    Dir[Rails.root.join('lib', 'extensions', '**', '*.rb')].each { |f| require f }

    config.time_zone = 'Bangkok'
    config.i18n.default_locale = :th
    config.i18n.available_locales = [:th, :en]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.assets.initialize_on_precompile = false
  end
end

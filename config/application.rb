require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile,
# including any gems you've limited to
# :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsSaasStarterKit
  class Application < Rails::Application
    # Initialize configuration defaults
    # for originally generated Rails version.
    config.load_defaults 7.2

    # Autoload lib folder
    config.autoload_lib(ignore: %w[assets tasks])

    # API only app
    config.api_only = true

    # Sidekiq as ActiveJob adapter
    config.active_job.queue_adapter = :sidekiq

    # Enable cookies for Sidekiq Web UI
    config.middleware.use ActionDispatch::Cookies

    # Enable sessions for Sidekiq Web UI
    config.middleware.use ActionDispatch::Session::CookieStore,
      key: '_rails_saas_starter_kit_session'
  end
end
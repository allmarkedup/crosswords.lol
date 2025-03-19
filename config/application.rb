require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_cable/engine"
require "action_view/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Crisscross
  class Application < Rails::Application
    config.load_defaults 8.0

    config.autoload_once_paths << "#{root}/app/serializers"
    config.autoload_lib(ignore: %w[assets tasks])

    config.generators.system_tests = nil
    config.app_generators { _1.test_framework _1.test_framework, fixture: false }

    config.action_mailer.delivery_method = :mailgun
    if Rails.application.credentials.mailgun
      config.action_mailer.mailgun_settings = {
        domain: Rails.application.credentials.mailgun.domain,
        api_key: Rails.application.credentials.mailgun.api_key
      }
    end

    config.hosts << "crosswords.ngrok.dev"
    config.hosts << "crosswords.lol"
  end
end

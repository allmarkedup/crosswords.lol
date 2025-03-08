require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
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

    config.hosts << "crosswords.ngrok.dev"
    config.hosts << "crosswords.lol"

    # config.logger = Logger.new($stdout)
    # config.logger.level = Logger::DEBUG
  end
end

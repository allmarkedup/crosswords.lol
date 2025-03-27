ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require "capybara/rails"
require "capybara/dsl"
require "capybara/minitest"
require "capybara/minitest/spec"

require "minitest/spec"
require "minitest/reporters"

Capybara.default_driver = :selenium_chrome_headless

class ActiveSupport::TestCase
  extend Minitest::Spec::DSL
end

class ActionDispatch::IntegrationTest
  extend Minitest::Spec::DSL
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

module ActiveSupport
  class TestCase
    include Oaken::TestSetup

    parallelize(workers: :number_of_processors)
  end
end

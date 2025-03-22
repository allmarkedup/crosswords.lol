ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

require "minitest/spec"
require "minitest/reporters"

class ActiveSupport::TestCase
  extend Minitest::Spec::DSL
end

class ActionDispatch::IntegrationTest
  extend Minitest::Spec::DSL
end

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

module ActiveSupport
  class TestCase
    include Oaken::TestSetup

    parallelize(workers: :number_of_processors)
  end
end

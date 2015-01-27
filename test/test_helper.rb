require "simplecov"
SimpleCov.start

require "active_support"
require "minitest/autorun"
require "mocha/setup"
require "pry"

require "minitest/reporters"
Minitest::Reporters.use!(Minitest::Reporters::DefaultReporter.new)

ActiveSupport::TestCase.test_order = :random

require "api_tommy"

system('mkdir', '-p', 'doc')

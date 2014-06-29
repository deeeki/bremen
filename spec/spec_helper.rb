if ENV['CI'] && RUBY_VERSION.start_with?('2.1')
  require 'coveralls'
  require 'codeclimate-test-reporter'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    Coveralls::SimpleCov::Formatter,
    CodeClimate::TestReporter::Formatter
  ]
  SimpleCov.start 'test_frameworks'
end

require 'minitest/autorun'
require 'minitest/pride'
require 'bremen'

def fixture path
  File.read("#{File.dirname(__FILE__)}/fixtures/#{path}")
end

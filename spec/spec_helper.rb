if ENV['CI'] && RUBY_VERSION.start_with?('2.1')
  require 'coveralls'
  Coveralls.wear!('test_frameworks')
end
if ENV['CODECLIMATE_REPO_TOKEN'] && RUBY_VERSION.start_with?('2.1')
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require 'minitest/autorun'
require 'minitest/pride'
require 'bremen'

def fixture path
  File.read("#{File.dirname(__FILE__)}/fixtures/#{path}")
end

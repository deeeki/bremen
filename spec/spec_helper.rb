if ENV['CI'] && RUBY_VERSION.start_with?('2.1')
  require 'coveralls'
  Coveralls.wear!('test_frameworks')
end

require 'minitest/autorun'
require 'minitest/pride'
require 'bremen'

def fixture path
  File.read("#{File.dirname(__FILE__)}/fixtures/#{path}")
end

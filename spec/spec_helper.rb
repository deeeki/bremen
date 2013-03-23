require 'minitest/autorun'
require 'minitest/pride'
require 'bremen'
require 'coveralls'
Coveralls.wear!

def fixture path
  File.read("#{File.dirname(__FILE__)}/fixtures/#{path}")
end

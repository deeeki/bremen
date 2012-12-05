require 'minitest/autorun'
require 'minitest/pride'
require 'bremen'

def fixture path
  File.read("#{File.dirname(__FILE__)}/fixtures/#{path}")
end

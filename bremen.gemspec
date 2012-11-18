# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bremen/version'

Gem::Specification.new do |gem|
  gem.name          = "bremen"
  gem.version       = Bremen::VERSION
  gem.authors       = ["itzki"]
  gem.email         = ["itzki.h@gmail.com"]
  gem.description   = %q{integrated searcher of audio track on music sites}
  gem.summary       = %q{integrated searcher of audio track on music sites}
  gem.homepage      = "https://github.com/itzki/bremen"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end

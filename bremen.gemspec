# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bremen/version'

Gem::Specification.new do |gem|
  gem.name          = "bremen"
  gem.version       = Bremen::VERSION
  gem.authors       = ["deeeki"]
  gem.email         = ["deeeki@gmail.com"]
  gem.description   = %q{integrated searcher of audio tracks on music sites}
  gem.summary       = %q{Bremen provides common search interface for some music websites. it supports YouTube, SoundCloud, MixCloud and Nicovideo}
  gem.homepage      = "https://github.com/deeeki/bremen"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'guard-minitest', ['>= 0']
  gem.add_development_dependency 'rb-fsevent', ['>= 0']
  gem.add_development_dependency 'terminal-notifier-guard', ['>= 0']
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'coveralls'
end

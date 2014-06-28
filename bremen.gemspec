# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bremen/version'

Gem::Specification.new do |spec|
  spec.name          = "bremen"
  spec.version       = Bremen::VERSION
  spec.authors       = ["deeeki"]
  spec.email         = ["deeeki@gmail.com"]
  spec.summary       = %q{integrated searcher of audio tracks on music sites}
  spec.description   = %q{Bremen provides common search interface for some music websites. it supports YouTube, SoundCloud, MixCloud and Nicovideo}
  spec.homepage      = "https://github.com/deeeki/bremen"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'guard-minitest', ['>= 0']
  spec.add_development_dependency 'rb-fsevent', ['>= 0']
  spec.add_development_dependency 'terminal-notifier-guard', ['>= 0']
end

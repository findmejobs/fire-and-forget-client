# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fire-and-forget-client/version'

Gem::Specification.new do |gem|
  gem.name          = "fire-and-forget-client"
  gem.version       = FireAndForget::VERSION
  gem.authors       = ["Ted Kulp"]
  gem.email         = ["ted@tedkulp.com"]
  gem.description   = %q{Client gem for the Fire and Forget tracking daemon.}
  gem.summary       = %q{Client gem for the Fire and Forget tracking daemon.}
  gem.homepage      = "https://github.com/tedkulp/fire-and-forget-client"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-spies"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "yard"
end

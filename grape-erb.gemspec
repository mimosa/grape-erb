# -*- encoding: utf-8 -*-
require File.expand_path('../lib/grape-erb/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Howl王"]
  gem.email         = ["howl.wong@gmail.com"]
  gem.description   = %q{Use erb in grape}
  gem.summary       = %q{Use erb in grape}
  gem.homepage      = "https://github.com/mimosa/grape-erb"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.name          = "grape-erb"
  gem.require_paths = ["lib"]
  gem.version       = Grape::Erb::VERSION
  gem.required_ruby_version = '>= 1.9.3'

  gem.add_dependency "grape"
  gem.add_dependency "erubis"
  gem.add_dependency "tilt"
  gem.add_dependency "i18n"
end

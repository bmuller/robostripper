lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'robostripper/version'

Gem::Specification.new do |gem|
  gem.name          = "robostripper"
  gem.version       = Robostripper::VERSION
  gem.authors       = ["Brian Muller"]
  gem.email         = ["bamuller@gmail.com"]
  gem.description   = %q{Strip HTML websites as though they provided a REST interface.  Like a Robot.}
  gem.summary       = %q{Strip HTML websites as though they provided a REST interface.  Like a Robot.}
  gem.homepage      = "https://github.com/bmuller/robostripper"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency("httparty", ">= 0.9.0")
  gem.add_dependency("nokogiri", ">= 1.5.6")
  gem.add_development_dependency("rake")
  gem.add_development_dependency("rdoc")
  gem.add_development_dependency("minitest")
end

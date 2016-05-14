# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'confidelius/version'

DESCRIPTION = <<DESC
Deal with confidential data more securly.
Read more on the Github README.
DESC

Gem::Specification.new do |spec|
  spec.name          = "confidelius"
  spec.version       = Confidelius::VERSION
  spec.authors       = ["Sebastian Pältz"]
  spec.email         = ["basti@kaderx.com"]

  spec.summary       = "Deal with confidential data more securly"
  spec.description   = DESCRIPTION
  spec.homepage      = "https://github.com/BastiPaeltz/confidelius.git"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   << "confidelius"
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "docopt", "~> 0.5.0"
  spec.add_runtime_dependency "sqlite3", "~> 1.3", ">= 1.3.11"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "manpages/version"

Gem::Specification.new do |spec|
  spec.name          = "manpages"
  spec.version       = Manpages::VERSION
  spec.authors       = ["Bodo Tasche"]
  spec.email         = ["bodo@tasche.me"]

  spec.summary       = "Adds support for man pages to rubygems"
  spec.description   = "With this gem the rubygems command will detect man pages within gems and exposes them to the man command."
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/bitboxer/manpages"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|Gemfile|Gemfile.lock)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0"
  spec.add_development_dependency "rubocop", "~> 0.44.1"
end

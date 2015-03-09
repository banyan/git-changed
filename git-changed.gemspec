# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/modified/version'

Gem::Specification.new do |spec|
  spec.name          = "git-modified"
  spec.version       = Git::Modified::VERSION
  spec.authors       = ["Kohei Hasegawa"]
  spec.email         = ["ameutau@gmail.com"]

  spec.summary       = %q{A Git subcommand to list modified files in git commit}
  spec.description   = %q{A Git subcommand to list modified files in git commit}
  spec.homepage      = "https://github.com/banyan/git-modified"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "contracts", "~> 0.7"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

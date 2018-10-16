# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dry/system/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "dry-system-rails"
  spec.version       = Dry::System::Rails::VERSION
  spec.authors       = ["Roman Novoselov"]
  spec.email         = ["rnovoselov93@gmail.com"]

  spec.summary       = %q{Folder resolver for dry-system in rails projects without pain}
  spec.description   = %q{Folder resolver for dry-system in rails projects without pain}
  spec.homepage      = 'https://github.com/romkaspb/dry-system-rails'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end

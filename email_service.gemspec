# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'email_service/version'

Gem::Specification.new do |spec|
  spec.name          = "email_service"
  spec.version       = EmailService::VERSION
  spec.authors       = ["rutvij"]
  spec.email         = ["rutvij.pandya.2010@gmail.com"]
  spec.summary       = %q{EmailService is an internal email service wrapper}
  spec.description   = %q{EmailService is an internal email service wrapper}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "mosaic-lyris", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", '~> 0'
end

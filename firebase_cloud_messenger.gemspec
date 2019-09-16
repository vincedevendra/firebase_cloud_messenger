# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'firebase_cloud_messenger/version'

Gem::Specification.new do |spec|
  spec.name          = "firebase_cloud_messenger"
  spec.version       = FirebaseCloudMessenger::VERSION
  spec.license       = "MIT"
  spec.authors       = ["Vince DeVendra"]
  spec.email         = ["vdevendra@patientslikeme.com"]
  spec.homepage      = "https://github.com/patientslikeme/firebase_cloud_messenger"

  spec.summary       = %q{A wrapper for the Firebase Cloud Messaging API}
  spec.description   = spec.summary
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "googleauth",  "~> 0.6"
  spec.add_runtime_dependency "json-schema", "~> 2.8"

  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "pry"
end

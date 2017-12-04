# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'firebase_cloud_messenger/version'

Gem::Specification.new do |spec|
  spec.name          = "FirebaseCloudMessenger"
  spec.version       = FirebaseCloudMessenger::VERSION
  spec.authors       = ["Vince DeVendra"]
  spec.email         = ["vdevendra@patientslikeme.com"]

  spec.summary       = %q{: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{: Write a longer description or delete this line.}
  spec.test_files    = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "googleauth"

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'pry'
end

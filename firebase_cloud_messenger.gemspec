# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'firebase_cloud_messenger/version'

Gem::Specification.new do |spec|
  spec.name          = "firebase-cloud-messenger"
  spec.version       = FirebaseCloudMessenger::VERSION
  spec.authors       = ["Vince DeVendra"]
  spec.email         = ["vdevendra@patientslikeme.com"]

  spec.summary       = %q{A ruby api wrapper for the FirebaseCloudMesenger API}
  spec.description   = spec.summary
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "googleauth"
  spec.add_runtime_dependency "json-schema"

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'pry'
end

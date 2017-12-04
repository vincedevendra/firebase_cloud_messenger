# coding: utf-8
require File.expand_path('../../../local_gem_config', __FILE__)
gem_name = File.basename(__FILE__).split(".").first

LocalGem::Specification.new(gem_name) do |spec|
  spec.test_files = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "googleauth"

  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'pry'
end.spec

require 'bundler'
Bundler.require
require 'rails/all'
require 'rails/generators'

require './lib/frontier'

def build_model_configuration
  ModelConfiguration::YamlParser.new(test_model_path).model_configuration
end

def test_model_path
  File.join("spec", "support", "test_model.yaml")
end

RSpec.configure do |config|
  config.mock_with :rspec
end

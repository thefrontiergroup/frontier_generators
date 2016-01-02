require 'bundler'
Bundler.require
require 'rails/all'

require './lib/frontier'

def build_model_configuration
  test_model_path = File.join("spec", "support", "test_model.yaml")
  ModelConfiguration::YamlParser.new(test_model_path).model_configuration
end

RSpec.configure do |config|
  config.mock_with :rspec
end

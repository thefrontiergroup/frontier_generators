require 'bundler'
Bundler.require
require 'rails/all'

Dir.glob("./lib/model_configuration/**/*.rb", &method(:require))
Dir.glob("./lib/support/**/*.rb", &method(:require))

def build_model_configuration
  test_model_path = File.join("spec", "support", "test_model.yaml")
  ModelConfiguration.new(test_model_path)
end

RSpec.configure do |config|
  config.mock_with :rspec
end
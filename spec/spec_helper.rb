require 'bundler'
Bundler.require
require 'rails/all'

Dir.glob("./lib/model_configuration/**/*.rb", &method(:require))

def build_model_configuration
  test_model_path = File.join("spec", "support", "test_model.yaml")
  ModelConfiguration.new(test_model_path)
end
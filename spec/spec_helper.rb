require 'bundler'
Bundler.require
require 'rails/all'

Dir.glob("./lib/model_configuration/**/*.rb", &method(:require))
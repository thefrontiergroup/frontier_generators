require_relative "../../model_configuration/model_configuration"

class FrontierControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  attr_accessor :model_configuration

  def scaffold
    self.model_configuration = ModelConfiguration.new(ARGV[0])

    template "controller.rb", generate_controller_path
    template "controller_spec.rb", generate_controller_spec_path
  end

protected

  # Scaffold methods - called from within template

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def controller_name
    [*model_configuration.namespaces.map(&:camelize), "#{model_configuration.model_name.pluralize.camelize}Controller"].join("::")
  end

  # EG: Admin::DriversController < Admin::BaseController
  # EG: DriversController < ApplicationController
  def controller_name_and_superclass
    "#{controller_name} < #{get_superclass_for_controller}"
  end

private

  def generate_controller_path
    file_name = "#{model_configuration.model_name.pluralize}_controller.rb"
    File.join("app", "controllers", *model_configuration.namespaces, file_name)
  end

  def generate_controller_spec_path
    file_name = "#{model_configuration.model_name.pluralize}_controller_spec.rb"
    File.join("spec", "controllers", *model_configuration.namespaces, file_name)
  end


  # EG: Admin::Users::BaseController
  # EG: Admin::BaseController
  # EG: ApplicationController
  def get_superclass_for_controller
    if model_configuration.namespaces.any?
      [*model_configuration.namespaces.map(&:camelize), "BaseController"].join("::")
    else
      "ApplicationController"
    end
  end

end

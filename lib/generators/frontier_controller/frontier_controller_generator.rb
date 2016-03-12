require_relative "../../frontier"

class FrontierControllerGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    unless model_configuration.skip_ui?
      template "controller.rb", generate_controller_path
      template "controller_spec.rb", generate_controller_spec_path
    end
  end

protected

  def instance_actions
    @instance_actions ||= Frontier::Views::Index::InstanceActions.new(model_configuration)
  end

  # Scaffold methods - called from within template

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def controller_name
    [
      *model_configuration.namespaces.map(&:camelize),
      "#{model_configuration.model_name.pluralize.camelize}Controller"
    ].join("::")
  end

  # EG: Admin::DriversController < Admin::BaseController
  # EG: DriversController < ApplicationController
  def controller_name_and_superclass
    "#{controller_name} < #{superclass_for_controller}"
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
  def superclass_for_controller
    if model_configuration.namespaces.any?
      [*model_configuration.namespaces.map(&:camelize), "BaseController"].join("::")
    else
      "ApplicationController"
    end
  end

end

class Frontier::Controller::ImplementationPath

  include Frontier::ModelConfigurationProperty

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def to_s
    File.join(
      "app",
      "controllers",
      *model_configuration.controller_prefixes.map(&:as_route_component),
      file_name
    ).to_s
  end

private

  def file_name
    "#{model_configuration.model_name.pluralize}_controller.rb"
  end

end

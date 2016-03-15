class Frontier::Controller::ClassName

  include Frontier::ModelConfigurationProperty

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def to_s
    [
      *model_configuration.controller_prefixes.map(&:as_snake_case).map(&:camelize),
      "#{model_configuration.model_name.pluralize.camelize}Controller"
    ].join("::")
  end

end

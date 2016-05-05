class Frontier::Controller::SpecPath

  include Frontier::ModelConfigurationProperty

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def to_s
    File.join(
      "spec",
      "controllers",
      *model_configuration.controller_prefixes.map(&:as_snake_case),
      file_name
    ).to_s
  end

private

  def file_name
    "#{model_configuration.model_name.pluralize}_controller_spec.rb"
  end

end

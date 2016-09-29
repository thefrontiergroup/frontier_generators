class Frontier::Controller::SpecPath

  include Frontier::ModelProperty

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def to_s
    File.join(
      "spec",
      "controllers",
      *model.controller_prefixes.map(&:as_snake_case),
      file_name
    ).to_s
  end

private

  def file_name
    "#{model.name.as_collection}_controller_spec.rb"
  end

end

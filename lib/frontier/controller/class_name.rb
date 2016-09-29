class Frontier::Controller::ClassName

  include Frontier::ModelProperty

  # EG: Admin::Users::DriversController
  # EG: Admin::DriversController
  # EG: DriversController
  def to_s
    [
      *model.controller_prefixes.map(&:as_snake_case).map(&:camelize),
      "#{model.name.as_plural.camelize}Controller"
    ].join("::")
  end

end

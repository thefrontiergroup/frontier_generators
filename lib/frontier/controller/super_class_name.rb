class Frontier::Controller::SuperClassName

  include Frontier::ModelConfigurationProperty

  # EG: Admin::Users::BaseController
  # EG: Admin::BaseController
  # EG: ApplicationController
  def to_s
    if model_configuration.controller_prefixes.any?
      [
        *model_configuration.controller_prefixes.map(&:as_snake_case).map(&:camelize),
        "BaseController"
      ].join("::")
    else
      "ApplicationController"
    end
  end

end

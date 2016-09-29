class Frontier::Controller::SuperClassName

  include Frontier::ModelProperty

  # EG: Admin::Users::BaseController
  # EG: Admin::BaseController
  # EG: ApplicationController
  def to_s
    if model.controller_prefixes.any?
      [
        *model.controller_prefixes.map(&:as_snake_case).map(&:camelize),
        "BaseController"
      ].join("::")
    else
      "ApplicationController"
    end
  end

end

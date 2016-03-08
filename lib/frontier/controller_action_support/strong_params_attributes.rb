class Frontier::ControllerActionSupport::StrongParamsAttributes

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_array
    []
  end

end

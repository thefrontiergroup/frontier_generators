class Frontier::ControllerSpec::SubjectBlock

  attr_reader :model_configuration, :method, :action, :params

  def initialize(model_configuration, method, action, params={})
    @model_configuration = model_configuration
    @method = method
    @action = action
    @params = params
  end

  def to_s
    "subject { #{method} :#{action} }"
  end

end

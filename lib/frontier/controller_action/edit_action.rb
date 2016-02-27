class Frontier::ControllerAction::EditAction

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_s
    raw = <<-STRING
def new
  #{model_configuration.as_ivar_instance} = find_#{model_configuration.model_name}
  #{Frontier::Authorization::Assertion.new(model_configuration, :edit).to_s}
end
STRING
    raw.rstrip
  end

end

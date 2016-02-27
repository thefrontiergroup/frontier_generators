class Frontier::ControllerAction::NewAction

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_s
    raw = <<-STRING
def new
  #{model_configuration.as_ivar_instance} = #{model_configuration.as_constant}.new
  #{Frontier::Authorization::Assertion.new(model_configuration, :new).to_s}
end
STRING
    raw.rstrip
  end

end

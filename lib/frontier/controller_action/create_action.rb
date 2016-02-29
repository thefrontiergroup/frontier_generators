class Frontier::ControllerAction::CreateAction

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_s
    raw = <<-STRING
def create
  #{model_configuration.as_ivar_instance} = #{model_configuration.as_constant}.new(strong_params_for(#{model_configuration.as_constant}))
  #{model_configuration.as_ivar_instance}.save if #{Frontier::Authorization::Assertion.new(model_configuration, :create).to_s}

  respond_with(#{model_configuration.as_ivar_instance}, location: #{model_configuration.url_builder.index_path})
end
STRING
    raw.rstrip
  end

end

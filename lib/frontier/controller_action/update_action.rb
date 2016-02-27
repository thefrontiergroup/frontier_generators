class Frontier::ControllerAction::UpdateAction

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_s
    raw = <<-STRING
def new
  #{model_configuration.as_ivar_instance} = find_#{model_configuration.model_name}
  #{model_configuration.as_ivar_instance}.assign_attributes(strong_params_for(#{model_configuration.as_constant}))
  #{model_configuration.as_ivar_instance}.save if #{Frontier::Authorization::Assertion.new(model_configuration, :edit).to_s}

  respond_with(#{model_configuration.as_ivar_instance}, location: #{model_configuration.url_builder.index_path})
end
STRING
    raw.rstrip
  end

end

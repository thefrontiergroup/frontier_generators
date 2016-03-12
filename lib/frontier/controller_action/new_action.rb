class Frontier::ControllerAction::NewAction

  include Frontier::ModelConfigurationProperty

  ##
  # Renders the new action for a controller. EG:
  #
  # def new
  #   @model_name = ModelName.new
  #   authorize!(@model_name)
  #   @model_name.build_address # if nested, we need to pre-populate the form
  #   @model_name.address.build_state # if deeply nested
  # end
  def to_s
    [
      "def new",
      Frontier::RubyRenderer.new(action_contents.join("\n")).render(1),
      "end"
    ].join("\n")
  end

private

  def action_contents
    [
      "#{model_configuration.as_ivar_instance} = #{model_configuration.as_constant}.new",
      Frontier::Authorization::Assertion.new(model_configuration, :new).to_s,
      Frontier::ControllerActionSupport::NestedAssociationBuilder.new(model_configuration, model_configuration.as_ivar_instance).to_s
    ].flatten.compact
  end

end

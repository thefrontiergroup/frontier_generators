class Frontier::ControllerAction::NewAction

  include Frontier::ModelProperty

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
      "#{model.name.as_ivar_instance} = #{scopable_object}.new",
      Frontier::Authorization::Assertion.new(model, :new).to_s,
      Frontier::ControllerActionSupport::NestedAssociationBuilder.new(model, model.name.as_ivar_instance).to_s
    ].flatten.compact
  end

  def scopable_object
    Frontier::ControllerActionSupport::ScopableObject.new(model).to_s
  end

end

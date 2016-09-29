class Frontier::ControllerAction::EditAction

  include Frontier::ModelProperty

  ##
  # Renders the edit action for a controller. EG:
  #
  # def edit
  #   @model_name = find_model_name
  #   authorize!(@model_name)
  #   if @model_name.address.blank? # if shallow nested, we need to pre-populate the form
  #     @model_name.build_address
  #     @model_name.address.build_state # if deeply nested
  #   end
  # end
  #
  def to_s
    [
      "def edit",
      Frontier::RubyRenderer.new(action_contents.join("\n")).render(1),
      "end"
    ].join("\n")
  end

private

  def action_contents
    [
      "#{model.name.as_ivar_instance} = find_#{model.name.as_singular}",
      Frontier::Authorization::Assertion.new(model, :edit).to_s,
      Frontier::ControllerActionSupport::NestedAssociationBuilder.new(model, model.name.as_ivar_instance).to_s
    ].flatten.compact
  end

end

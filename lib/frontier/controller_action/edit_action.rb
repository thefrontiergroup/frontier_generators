class Frontier::ControllerAction::EditAction

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  # def edit
  #   @model_name = find_model_name
  #   authorize!(@model_name)
  #   @model_name.build_address if @model_name.address.blank? # if shallow nested, we need to pre-populate the form
  #   @model_name.build_address.build_state if @model_name.address.blank? # if deeply nested (only one line will be shown)
  # end
  def to_s
    ["def edit", indented_action_contents, "end"].join("\n")
  end

private

  def action_contents
    [
      "#{model_configuration.as_ivar_instance} = find_#{model_configuration.model_name}",
      Frontier::Authorization::Assertion.new(model_configuration, :edit).to_s,
      build_association_models(model_configuration)
    ].flatten.compact
  end

  # @model_name.build_address # or
  # @model_name.address.build_state
  def build_association_model_for(association, prefix)
    nested_associations_for(association).collect {|association| "build_#{association}"}
    "#{prefix || model_configuration.as_ivar_instance}.build_#{association.name}"
  end

  def build_association_models(model_configuration_or_association)
    nested_associations_for(model_configuration_or_association).map do |association|
      build_association_model_for(association, prefix)
    end
  end

  def indented_action_contents
    action_contents.map {|loc| "  #{loc}"}.join("\n")
  end

  def nested_associations_for(model_configuration_or_association)
    nested_associations = model_configuration_or_association.attributes.select {|attribute| attribute.is_association? && attribute.is_nested?}
  end

end

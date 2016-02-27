class Frontier::ControllerAction::NewAction

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  # def new
  #   @model_name = ModelName.new
  #   authorize!(@model_name)
  #   @model_name.build_address # if nested, we need to pre-populate the form
  #   @model_name.address.build_state # if deeply nested
  # end
  def to_s
    ["def new", indented_action_contents, "end"].join("\n")
  end

private

  # @model_name.build_address # or
  # @model_name.address.build_state
  def build_association_model_for(association, prefix)
    "#{prefix || model_configuration.as_ivar_instance}.build_#{association.name}"
  end

  def build_association_models(model_configuration_or_association, prefix=nil)
    nested_associations = model_configuration_or_association.attributes.select {|attribute| attribute.is_association? && attribute.is_nested?}
    nested_associations.flat_map do |association|
      # Accomodate shallow nested associations
      [build_association_model_for(association, prefix)] +
      # Accomodate deeply nested associations
      build_association_models(association, "#{model_configuration.as_ivar_instance}.#{association.name}")
    end
  end

  def action_contents
    [
      "#{model_configuration.as_ivar_instance} = #{model_configuration.as_constant}.new",
      Frontier::Authorization::Assertion.new(model_configuration, :new).to_s,
      build_association_models(model_configuration)
    ].flatten.compact
  end

  def indented_action_contents
    action_contents.map {|loc| "  #{loc}"}.join("\n")
  end

end

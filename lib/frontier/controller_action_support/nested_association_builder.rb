class Frontier::ControllerActionSupport::NestedAssociationBuilder

  include Frontier::IndentRenderer

  attr_reader :indent_level
  # EG: Frontier::ModelConfiguration or Frontier::Association
  attr_reader :object_with_attributes
  # EG: @model_name
  # EG: @model_name.address
  attr_reader :parent_object

  def initialize(object_with_attributes, parent_object, indent_level=0)
    @indent_level = indent_level
    @object_with_attributes = object_with_attributes
    @parent_object = parent_object
  end

  # EG: Simple association
  #
  # @model_name.build_address if @model_name.address.blank?
  #
  # EG: Single nested
  #
  # if @model_name.address.blank?
  #   @model_name.build_address
  #   @model_name.address.build_state
  # end
  #
  # EG: Multi nested (depth and breadth)
  #
  # if @model_name.address.blank?
  #   @model_name.build_address
  #   @model_name.address.build_state
  #   @model_name.address.state.build_national_animal
  #   @model_name.address.build_contact_person
  # end
  #
  def to_s
    object_with_attributes.associations.select(&:is_nested?).map do |association|
      content = [
        render_build_statement(association),
        render_nested_build_statements(association),
      ]
      content = wrap_content_in_a_conditional(association, content) if indent_level == 0
      content.reject(&:empty?).join("\n")
    end.join("\n")
  end

private

  def render_build_statement(association)
    render_with_indent(indent_level, "#{parent_object}.build_#{association.name}")
  end

  def render_nested_build_statements(association)
    self.class.new(association, "#{parent_object}.#{association.name}", indent_level + 1).to_s
  end

  def wrap_content_in_a_conditional(association, content)
    content[0] = render_with_indent(indent_level + 1, content[0])
    [
      "if #{parent_object}.#{association.name}.blank?",
      *content,
      "end"
    ]
  end

end

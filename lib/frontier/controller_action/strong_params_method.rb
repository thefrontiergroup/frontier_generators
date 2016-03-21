class Frontier::ControllerAction::StrongParamsMethod

  include Frontier::ModelConfigurationProperty

  def to_s
    if model_configuration.attributes.count > 3 || contains_nested_associations?
      render_multi_line_strong_params
    else
      render_single_line_strong_params
    end
  end

private

  def attributes_as_strong_params
    strong_params_from_attributes(model_configuration.attributes)
  end

  def strong_params_from_attributes(attributes)
    attributes.map do |attribute_or_association|
      attribute_or_association_as_strong_params(attribute_or_association)
    end
  end

  def contains_nested_associations?
    model_configuration.associations.any?(&:is_nested?)
  end

  def params_require_preamble
    "params.require(#{model_configuration.as_symbol}).permit"
  end

  def strong_params_method
    raw = <<-STRING
def strong_params_for_#{model_configuration.model_name}
  #{yield}
end
STRING
    raw.rstrip
  end

  def attribute_or_association_as_strong_params(attribute_or_association)
    if attribute_or_association.is_association? && attribute_or_association.is_nested?
      nested_association_as_strong_params(attribute_or_association)
    elsif attribute_or_association.is_association?
      attribute_or_association.as_field_name
    else
      attribute_or_association.as_symbol
    end
  end

  # EG: {address_attributes: [:id, :name]}
  # EG: {address_attributes: [:id, :name, {state_attributes: [:abbreviation, :name]}]}
  def nested_association_as_strong_params(association)
    "{#{association.name}_attributes: [#{strong_params_from_attributes(association.attributes).join(", ")}]}"
  end

  # EG:
  #
  # def attributs_for_user
  #   params.require(:user).permit([
  #     :email,
  #     :name,
  #     {address_attributes: [:id, :name]}
  #   ])
  # end
  #
  def render_multi_line_strong_params
    strong_params_method do
      params_over_multiple_lines = Frontier::RubyRenderer.new(attributes_as_strong_params.sort.join(",\n")).render(2)

      "#{params_require_preamble}([\n#{params_over_multiple_lines}\n#{render_with_indent(1, ']')})"
    end
  end

  # EG:
  #
  # def attributs_for_user
  #   params.require(:user).permit([:email, :name])
  # end
  #
  def render_single_line_strong_params
    strong_params_method do
      "#{params_require_preamble}([#{attributes_as_strong_params.sort.join(", ")}])"
    end
  end

end
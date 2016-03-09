class Frontier::ControllerAction::StrongParamsMethod

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_s
    if strong_params.count > 3 || contains_nested_associations?
      render_multi_line_strong_params
    else
      render_single_line_strong_params
    end
  end

private

  def contains_nested_associations?
    model_configuration.associations.any?(&:is_nested?)
  end

  def params_require_preamble
    "params.require(#{model_configuration.as_symbol}).permit"
  end

  def strong_params
    @strong_params ||= Frontier::ControllerActionSupport::StrongParamsAttributes.new(model_configuration).to_array
  end

  def strong_params_method
    raw = <<-STRING
def attributes_for_#{model_configuration.model_name}
  #{yield}
end
STRING
    raw.rstrip
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
      params_over_multiple_lines = strong_params.to_s
                                                .sub(/^\[/, "")
                                                .gsub(", ", ",\n")
                                                .sub(/\]$/, "")
      params_over_multiple_lines = Frontier::RubyRenderer.new(params_over_multiple_lines).render(1)
      params_over_multiple_lines = Frontier::RubyRenderer.new("#{params_over_multiple_lines}\n]").render(1)
      "#{params_require_preamble}([\n#{params_over_multiple_lines})"
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
      "#{params_require_preamble}(#{strong_params})"
    end
  end

end

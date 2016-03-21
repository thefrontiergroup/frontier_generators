class Frontier::ControllerAction::FindMethod

  include Frontier::ModelConfigurationProperty

  ##
  # Renders the find method for a controller. EG:
  #
  # def find_model_name
  #   ModelName.find(params[:id])
  # end
  #
  def to_s
    [
      "def find_#{model_configuration.model_name}",
      Frontier::RubyRenderer.new(action_contents).render(1),
      "end"
    ].join("\n")
  end

private

  def action_contents
    deepest_nested_model = model_configuration.controller_prefixes.select(&:nested_model?).last
    if deepest_nested_model.present?
      "#{deepest_nested_model.name}.#{model_configuration.as_collection}.find(params[:id])"
    else
      "#{model_configuration.as_constant}.find(params[:id])"
    end
  end

end

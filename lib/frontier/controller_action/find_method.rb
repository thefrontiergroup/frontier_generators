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
    "#{scopable_object}.find(params[:id])"
  end

  def scopable_object
    Frontier::ControllerActionSupport::ScopableObject.new(model_configuration).to_s
  end

end

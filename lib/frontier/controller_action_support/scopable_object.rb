class Frontier::ControllerActionSupport::ScopableObject

  include Frontier::ModelConfigurationProperty

  def to_s
    deepest_nested_model = model_configuration.controller_prefixes.select(&:nested_model?).last
    if deepest_nested_model.present?
      # @user.test_models
      "#{deepest_nested_model.name}.#{model_configuration.as_collection}"
    else
      # TestModel
      model_configuration.as_constant
    end
  end

end

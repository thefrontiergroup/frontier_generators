class Frontier::ControllerActionSupport::ScopableObject

  include Frontier::ModelProperty

  def to_s
    deepest_nested_model = model.controller_prefixes.select(&:nested_model?).last
    if deepest_nested_model.present?
      # @user.test_models
      "#{deepest_nested_model.name}.#{model.name.as_plural}"
    else
      # TestModel
      model.name.as_constant
    end
  end

end

class Frontier::ControllerActionSupport::ScopableObject

  include Frontier::ModelProperty

  def to_s
    deepest_nested_model = model.controller_prefixes.select(&:nested_model?).last
    if deepest_nested_model.present?
      # @user.test_models
      "#{deepest_nested_model.name}.#{model.as_collection}"
    else
      # TestModel
      model.as_constant
    end
  end

end

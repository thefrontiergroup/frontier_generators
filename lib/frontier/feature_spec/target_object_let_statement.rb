class Frontier::FeatureSpec::TargetObjectLetStatement

  include Frontier::ModelConfigurationProperty

  def to_s
    Frontier::SpecSupport::LetStatement.new(model_configuration.model_name, factory_girl_call).to_s(has_bang: true)
  end

private

  def factory_girl_call
    Frontier::FactoryGirlSupport::Declaration.new("create", model_configuration).to_s
  end

end

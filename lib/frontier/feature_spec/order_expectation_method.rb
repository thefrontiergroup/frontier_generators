class Frontier::FeatureSpec::OrderExpectationMethod

  include Frontier::ModelConfigurationProperty

  def method_name
    "expect_#{model_configuration.as_collection}_to_be_ordered"
  end

end

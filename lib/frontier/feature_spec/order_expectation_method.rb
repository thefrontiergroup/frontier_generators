class Frontier::FeatureSpec::OrderExpectationMethod

  include Frontier::ModelConfigurationProperty

  def method_name
    "expect_#{model_configuration.as_collection}_to_be_ordered"
  end

  def to_s
    raw = <<STRING
def #{method_name}(first, second)
  within(first_row)  { expect(page).to have_content(first.#{primary_attribute_name}) }
  within(second_row) { expect(page).to have_content(second.#{primary_attribute_name}) }
end
STRING
    raw.rstrip
  end

private

  def primary_attribute_name
    model_configuration.primary_attribute.name
  end

end

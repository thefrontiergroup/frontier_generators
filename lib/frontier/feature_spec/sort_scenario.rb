class Frontier::FeatureSpec::SortScenario

  attr_reader :model_configuration, :attribute_or_association

  def initialize(model_configuration, attribute_or_association)
    @model_configuration      = model_configuration
    @attribute_or_association = attribute_or_association
  end

  def to_s
    raw = <<STRING
scenario "sorting by '#{attribute_or_association.name}'" do
  second = #{Frontier::FactoryGirlSupport::Declaration.new(:create, model_configuration).to_s}
  first  = #{Frontier::FactoryGirlSupport::Declaration.new(:create, model_configuration).to_s}

  visit_index
end
STRING
    raw.rstrip
  end

end

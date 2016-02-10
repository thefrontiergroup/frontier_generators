class Frontier::FactoryGirlSupport::AttributesFor

  attr_reader :model_configuration_or_association

  def initialize(model_configuration_or_association)
    @model_configuration_or_association = model_configuration_or_association
  end

  def to_s
    Frontier::FactoryGirlSupport::Declaration.new("attributes_for", model_configuration_or_association).to_s
  end

end

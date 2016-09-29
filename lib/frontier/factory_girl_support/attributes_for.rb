class Frontier::FactoryGirlSupport::AttributesFor

  attr_reader :model_or_association

  def initialize(model_or_association)
    @model_or_association = model_or_association
  end

  def to_s
    Frontier::FactoryGirlSupport::Declaration.new("attributes_for", model_or_association).to_s
  end

end

class Frontier::FeatureSpecAssignment

  attr_reader :attribute_or_association

  def initialize(attribute_or_association)
    @attribute_or_association = attribute_or_association
  end

  def to_s
    if attribute_or_association.is_a?(Frontier::Association)
      Frontier::Association::FeatureSpecAssignment.new(attribute_or_association).to_s
    else
      Frontier::Attribute::FeatureSpecAssignment.new(attribute_or_association).to_s
    end
  end

end

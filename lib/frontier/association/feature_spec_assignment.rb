class Frontier::Association::FeatureSpecAssignment

  attr_reader :association

  def initialize(association)
    @association = association
  end

  def to_s
    "select(#{association.name}, from: \"#{association.capitalized}\")"
  end

end

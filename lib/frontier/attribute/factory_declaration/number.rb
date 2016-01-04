class Frontier::Attribute::FactoryDeclaration::Number

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

  def to_s
    numericality_validation = attribute.validations.find {|validation| validation.key.to_s == "numericality"}
    if numericality_validation.present?
      min = numericality_validation.args[:greater_than] || numericality_validation.args[:greater_than_or_equal_to] || 0
      max = numericality_validation.args[:less_than] || numericality_validation.args[:less_than_or_equal_to] || 9999

      "rand(#{min}..#{max})"
    else
      "rand(9999)"
    end
  end

end

class Frontier::Attribute::FeatureSpecAssignment

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

  def to_s
    case attribute.type.to_sym
    when :boolean
      "check(\"#{attribute.capitalized}\")"
    when :date, :datetime, :decimal, :integer, :string, :text
      "fill_in(\"#{attribute.capitalized}\", with: #{get_value_from_attributes})"
    when :enum
      "select(#{get_value_from_attributes}, from: \"#{attribute.capitalized}\")"
    end
  end

private

  def get_value_from_attributes
    "attributes[#{attribute.as_symbol}]"
  end

end

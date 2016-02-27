class Frontier::Attribute::FeatureSpecAssignment

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

  def to_s(attributes_name="attributes")
    case attribute.type.to_sym
    when :boolean
      "check(\"#{attribute.capitalized}\")"
    when :date, :datetime, :decimal, :integer, :string, :text
      "fill_in(\"#{attribute.capitalized}\", with: #{get_value_from_attributes(attributes_name)})"
    when :enum
      "select(#{get_value_from_attributes(attributes_name)}, from: \"#{attribute.capitalized}\")"
    end
  end

private

  def get_value_from_attributes(attributes_name)
    "#{attributes_name}[#{attribute.as_symbol}]"
  end

end

class Frontier::Factory

  include Frontier::ModelConfigurationProperty

  def to_s
    raw = <<-STRING
FactoryGirl.define do
  factory #{model_configuration.as_symbol} do
#{render_with_indent(2, factoried_attributes.join("\n"))}

    trait :invalid do
#{render_with_indent(3, invalid_attributes.join("\n"))}
    end
  end
end
STRING
    raw.rstrip
  end

private

  def factoried_attributes
    model_configuration.attributes.sort_by(&:name).map do |attribute|
      attribute.as_factory_declaration
    end
  end

  def invalid_attributes
    model_configuration.attributes.sort_by(&:name).map do |attribute|
      "#{attribute.name} nil"
    end
  end

end

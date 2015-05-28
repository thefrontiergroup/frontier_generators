class ModelConfiguration::Validation

  attr_reader :attribute, :key, :args

  # EG:
  # attribute: name
  # key: presence
  # args: true OR {message: "YOLO"}
  def initialize(attribute, key, args)
    @attribute = attribute
    @key = key
    @args = args
  end

  def implementation
    "validates #{attribute.as_symbol}, #{validations_for(attribute)}"
  end

private

  def validations_for(attribute)
    validations = attribute.properties[:validates].collect do |key, value|
      "#{key}: #{value}"
    end
    validations.join(", ")
  end

end
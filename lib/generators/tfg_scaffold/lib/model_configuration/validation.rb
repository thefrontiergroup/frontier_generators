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
    "validates #{attribute.as_symbol}, #{validations_for_attribute}"
  end

  def spec
    case key
    when "presence"
      "it { should validate_presence_of(#{attribute.as_symbol}) }"
    when "uniqueness"
      <<-RUBY
  it "ensures uniqueness of #{attribute.name}" do
    # TODO
  end
      RUBY
    else
      raise(ArgumentError, "Unknown validation: #{attribute.name}, #{validation_name}")
    end
  end

private

  def validations_for_attribute
    validations = attribute.properties[:validates].collect do |key, value|
      "#{key}: #{value}"
    end
    validations.join(", ")
  end

end
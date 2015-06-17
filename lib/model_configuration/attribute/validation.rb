class ModelConfiguration::Attribute::Validation

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

  def as_implementation
    "#{key}: #{print_args}"
  end

  def as_spec
    case key
    when "inclusion"
      "it { should validate_inclusion_of(#{attribute.as_symbol}).in_array(#{args}) }"
    when "numericality"
      ModelConfiguration::Attribute::Validation::Numericality.new(attribute, key, args).as_spec
    when "presence"
      "it { should validate_presence_of(#{attribute.as_symbol}) }"
    when "uniqueness"
      raise(ArgumentError, "uniqueness is a special validation that requires multiple lines of specs")
    else
      raise(ArgumentError, "unhandled validation requested: #{key}")
    end
  end

private

  def print_args
    if args.is_a?(Hash)
      print_args_as_hash
    else
      args
    end
  end

  # EG: {"jordan" => 1}, becomes "{jordan: 1}"
  def print_args_as_hash
    args_as_hash = args.collect do |key, value|
      "#{key}: #{value}"
    end.join(", ")
    "{#{args_as_hash}}"
  end

end

require_relative "./validation/numericality"
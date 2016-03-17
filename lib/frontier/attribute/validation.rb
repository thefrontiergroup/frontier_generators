class Frontier::Attribute::Validation

  attr_reader :attribute, :key, :args

  # EG:
  # attribute: name
  # key: presence
  # args: true OR {message: "YOLO"}
  def initialize(attribute, key, args)
    @attribute = attribute
    @key = key.to_s
    @args = args
  end

  def as_implementation
    case key
    when "inclusion"
      "#{key}: #{corresponding_constant.name}"
    else
      "#{key}: #{print_args}"
    end
  end

  def as_spec
    case key
    when "inclusion"
      "it { should validate_inclusion_of(#{attribute.as_symbol}).in_array(#{corresponding_constant.name}) }"
    when "presence"
      "it { should validate_presence_of(#{attribute.as_symbol}) }"
    when "uniqueness"
      raw = <<-STRING
describe "validating uniqueness" do
  subject { FactoryGirl.create(#{attribute.model_configuration.as_symbol}) }
  it { should validate_uniqueness_of(#{attribute.as_symbol}) }
end
STRING
      raw.rstrip
    else
      raise(ArgumentError, "unhandled validation requested: #{key}")
    end
  end

  def corresponding_constant
    if key == "inclusion"
      Frontier::Attribute::Constant.build_from_validation(attribute, self)
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

require_relative "./validation/factory"
require_relative "./validation/length"
require_relative "./validation/numericality"

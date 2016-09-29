class Frontier::Attribute::Validation::Uniqueness < Frontier::Attribute::Validation

  # attribute: name
  # key: "uniqueness"
  # args: true OR {scope: :user_id}
  def initialize(attribute, key, args)
    super

    # For a scope: argument, ensure the value is :value
    if args.is_a?(Hash) && args["scope"] && args["scope"].is_a?(String)
      args["scope"] = args["scope"].include?(":") ? args["scope"] : ":" + args["scope"]
    end
  end

  def as_spec
    if args.present?
      raw = <<-STRING
describe "validating uniqueness" do
  subject { FactoryGirl.create(#{attribute.model.as_symbol}) }
  it { should #{full_assertion} }
end
STRING
      raw.rstrip
    else
      raise(ArgumentError, "uniqueness validation must have at least one argument or be 'true'")
    end
  end

private

  def basic_assertion
    "validate_uniqueness_of(#{attribute.as_symbol})"
  end

  def additional_spec_options
    if args.present? && args.is_a?(Hash)
      additional_spec_options_collection
    end
  end

  # It is possible to have multiple. EG:
  #   minimum: 0
  #   maximum: 100
  # We should build: ["is_at_least(0)", "is_at_most(100)"]
  def additional_spec_options_collection
    args.collect do |key, value|
      case key.to_s
      when "scope"
        "scoped_to(#{value})"
      else
        raise(ArgumentError, "Unknown property: #{key}")
      end
    end
  end

  def full_assertion
    [basic_assertion, additional_spec_options].compact.join(".")
  end

end

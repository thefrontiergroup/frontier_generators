class Frontier::Attribute::Validation::Length < Frontier::Attribute::Validation

  def as_spec
    if args.present?
      "it { should #{full_spec} }"
    else
      raise(ArgumentError, "length validation must have at least one argument")
    end
  end

private

  def basic_spec
    "validate_length_of(#{attribute.as_symbol})"
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
      when "minimum"
        "is_at_least(#{value})"
      when "maximum"
        "is_at_most(#{value})"
      when "in", "within"
        "is_at_least(#{value.first}).is_at_most(#{value.last})"
      when "is"
        "is_equal_to(#{value})"
      else
        raise(ArgumentError, "Unknown property: #{key}")
      end
    end
  end

  def full_spec
    [basic_spec, additional_spec_options].compact.join(".")
  end

end

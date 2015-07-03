class ModelConfiguration::Attribute::Validation::Numericality < ModelConfiguration::Attribute::Validation

  def as_spec
    "it { should #{full_spec} }"
  end

private

  def basic_spec
    "validate_numericality_of(#{attribute.as_symbol})"
  end

  def additional_spec_options
    if args.present? && args.is_a?(Hash)
      additional_spec_options_collection
    end
  end

  # It is possible to have multiple. EG:
  #   greater_than: 0
  #   less_than: 100
  # We should build: ["is_greater_than(0)", "is_less_than(100)"]
  def additional_spec_options_collection
    additional_options = args.collect do |key, value|
      case key.to_s
      when "allow_nil"
        # allow_nil could be set to false, which we should just ignore
        if value
          "allow_nil"
        end
      when "greater_than"
        "is_greater_than(#{value})"
      when "greater_than_or_equal_to"
        "is_greater_than_or_equal_to(#{value})"
      when "equal_to"
        "is_equal_to(#{value})"
      when "less_than"
        "is_less_than(#{value})"
      when "less_than_or_equal_to"
        "is_less_than_or_equal_to(#{value})"
      else
        raise(ArgumentError, "Unknown property: #{key}")
      end
    end

    # Since allow_nil can be blank, we need to ensure that we do not return an empty array
    # to the #full_spec, otherwise a blank . will be added
    additional_options.any? ? additional_options : nil
  end

  def full_spec
    [basic_spec, additional_spec_options].compact.join(".")
  end

end
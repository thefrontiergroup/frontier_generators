require_relative '../attribute'

class ModelConfiguration::Attribute::InputImplementation

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

  def to_s(options={})
    # Should convert attribute "state" into:
    #   f.input :state_id, collection: State.all
    # With additional options as above you'd get:
    #   f.input :state_id, abacus: 666, collection: State.all, one: :two
    input_declaration = ["f.input #{attribute.as_field_name}", *input_options(options)].join(", ")
  end

private

  def attribute_options
    options = {}

    # For inclusion validations, we should ensure that the required values are passed as a
    # collection to the input. EG:
    #
    # attribute_name:
    #   validates:
    #     inclusion: [1, 2, 3]
    #
    # f.input :attribute_name, collection: [1, 2, 3]
    #
    if inclusion_validation = attribute.validations.find {|val| val.key.to_s == "inclusion" }
      options[:collection] = inclusion_validation.corresponding_constant.name
    end

    options
  end

  def input_options(additional_options)
    # Take options like {one: ':two', abacus: 666} and create collection of strings
    # ["abacus: 666", "one: :two"]
    additional_options_as_strings = attribute_options.merge(additional_options).map {|key, value| "#{key}: #{value}"}.sort
    additional_options_as_strings
  end

end
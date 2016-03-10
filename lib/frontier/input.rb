class Frontier::Input

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

protected

  def attribute_options
    options = {}

    # datetimes and dates should use the date_picker input type
    #
    # f.input :attribute_name, as: :date_picker
    if attribute.type.in?(["datetime", "date"])
      options[:as] = ":date_picker"
    end

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

  def form_name(options)
    options[:form_name] || "f"
  end

  def input_options(additional_options)
    # Ignore the form_name attribute
    additional_options = additional_options.dup
    additional_options.delete(:form_name)
    # Take options like {one: ':two', abacus: 666} and create collection of strings
    # ["abacus: 666", "one: :two"]
    additional_options_as_strings = attribute_options.merge(additional_options).map {|key, value| "#{key}: #{value}"}.sort
    additional_options_as_strings
  end

end

# Include these files after Frontier::Input has been defined
require_relative './input/association.rb'
require_relative './input/attribute.rb'
require_relative './input/factory.rb'
require_relative './input/inline_form_association.rb'
require_relative './input/select_form_association.rb'

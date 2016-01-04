class Frontier::Attribute::Factory

  def self.build_attribute_or_association(model_configuration, name, options)
    get_class_for_name_and_options(name, options).new(model_configuration, name, options)
  end

private

  def self.association_types
    [
      "belongs_to",
      "has_one",
      "has_many",
      "has_and_belongs_to_many"
    ]
  end

  def self.get_class_for_name_and_options(name, options)
    if options[:type].to_s.in?(association_types)
      Frontier::Association
    else
      Frontier::Attribute
    end
  end

end

require_relative '../attribute'
require_relative '../association'

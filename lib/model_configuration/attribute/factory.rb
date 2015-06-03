require_relative '../attribute'
require_relative '../association'

class ModelConfiguration::Attribute::Factory

  def self.build_attribute_or_association(name, options)
    get_class_for_name_and_options(name, options).new(name, options)
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
      ModelConfiguration::Association
    else
      ModelConfiguration::Attribute
    end
  end

end
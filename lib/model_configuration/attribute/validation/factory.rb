require_relative '../validation'
require_relative 'length'
require_relative 'numericality'

class ModelConfiguration::Attribute::Validation::Factory

  def build(attribute, key, args)
    case key
    when "length"
      ModelConfiguration::Attribute::Validation::Length.new(attribute, key, args)
    when "numericality"
      ModelConfiguration::Attribute::Validation::Numericality.new(attribute, key, args)
    else
      ModelConfiguration::Attribute::Validation.new(attribute, key, args)
    end
  end

end
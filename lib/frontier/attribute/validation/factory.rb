require_relative '../validation'
require_relative 'length'
require_relative 'numericality'

class Frontier::Attribute::Validation::Factory

  def build(attribute, key, args)
    case key
    when "length"
      Frontier::Attribute::Validation::Length.new(attribute, key, args)
    when "numericality"
      Frontier::Attribute::Validation::Numericality.new(attribute, key, args)
    else
      Frontier::Attribute::Validation.new(attribute, key, args)
    end
  end

end

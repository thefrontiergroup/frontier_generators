class ModelConfiguration::Attribute::Validation::Factory

  def build(attribute, key, args)
    case key
    when "numericality"
      ModelConfiguration::Attribute::Validation::Numericality.new(attribute, key, args)
    else
      ModelConfiguration::Attribute::Validation.new(attribute, key, args)
    end
  end

end
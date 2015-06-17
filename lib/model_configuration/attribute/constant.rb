require_relative '../attribute'

class ModelConfiguration::Attribute::Constant

  attr_reader :name, :values

  def self.build_from_validation(attribute, validation)
    name = "#{attribute.model_configuration.as_constant}::#{attribute.name.upcase}_VALUES"
    new(name, validation.args)
  end

  def initialize(name, values)
    @name = name
    @values = values
  end

  def model_implementation
    "#{name.split("::").last} = #{values}"
  end

end
class ModelConfiguration
  class ValidationString

    def self.for(attribute)
      if attribute.validation_required?
        "validates #{attribute.as_symbol}, #{validations_for(attribute)}"
      else
        raise(ArgumentError, "Provided attribute (#{attribute.name}) does not require validation")
      end
    end

  private

    def self.validations_for(attribute)
      validations = []

      attribute.properties[:validates].each do |key, value|
        validations << "#{key}: #{value}"
      end

      validations.join(", ")
    end

  end
end
class ModelConfiguration
  class ValidationSpecString

    def self.for(attribute)
      if attribute.validation_required?
        attribute.properties[:validates].collect do |validation_name, value|
          "it { should #{validation_spec_for(attribute, validation_name)} }"
        end.join("\n")
      else
        raise(ArgumentError, "Provided attribute (#{attribute.name}) does not require validation")
      end
    end

  private

    def self.validation_spec_for(attribute, validation_name)
      case validation_name.to_s
      when "presence"
        "validate_presence_of(#{attribute.as_symbol})"
      when "uniqueness"
        <<-RUBY
    it "ensures uniqueness of #{attribute.name}" do
      # TODO
    end
        RUBY
      else
        raise(ArgumentError, "Unknown validation: #{attribute.name}, #{validation_name}")
      end
    end

  end
end
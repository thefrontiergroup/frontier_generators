class Frontier::Spec::ObjectSetup::AttributesHash

  attr_reader :attributes_name, :model_configuration

  def initialize(model_configuration, attributes_name=nil)
    @attributes_name = attributes_name || "#{model_configuration.model_name}_attributes"
    @model_configuration = model_configuration
  end

  # Return a hash that represents the attributes that would be used in the setup for a controller
  # spec. EG:
  #
  #   let(:model_name_params) do
  #     {
  #       address_id: address.id,
  #       name: model_name_attributes[:name],
  #       address_attributes: {
  #         line_1: address_attributes[:line_1],
  #         line_2: address_attributes[:line_2],
  #         city: address_attributes[:city],
  #         state: state,
  #       }
  #     }
  #   end
  #
  # Would need a hash of:
  #
  #  {
  #    address_id: "address.id",
  #    name: "model_name_attributes[:name]",
  #    address_attributes: {
  #      line_1: "address_attributes[:line_1]",
  #      line_2: "address_attributes[:line_2]",
  #      city: "address_attributes[:city]",
  #      state: "state",
  #    }
  #  }
  #
  # Keep in mind, this method returns a hash. Another class will format this hash in a way
  # that can be rendered in the controller spec template.
  def to_hash
    hash = {}
    model_configuration.attributes.select(&:show_on_form?).each do |attribute|
      if attribute.is_attribute?
        # name: "attributes[:name]"
        hash[attribute.name.to_sym] = "#{attributes_name}[#{attribute.as_symbol}]"
      else
        if attribute.is_nested?
          hash["#{attribute.name}_attributes".to_sym] = self.class.new(attribute, "#{attribute.name}_attributes").to_hash
        else
          # address_id: "address.id"
          hash["#{attribute.name}_id".to_sym] = "#{attribute.name}.id"
        end
      end
    end
    hash
  end

end

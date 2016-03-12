class Frontier::SpecSupport::ObjectSetup::AttributesSetup

  include Frontier::ModelConfigurationProperty

  # Provide the let declarations that will be the basis of the attributes to be used in
  # the params:
  #
  #   let(:model_attributes) { FactoryGirl.attributes_for(:model) }
  #   let(:address_attributes) { FactoryGirl.attributes_for(:address) }
  #
  def to_s
    [
      model_attributes_let,
      *nested_attributes_lets
    ].compact.join("\n")
  end

private

  def model_attributes_let
    attributes_for = Frontier::FactoryGirlSupport::AttributesFor.new(model_configuration).to_s
    Frontier::SpecSupport::LetStatement.new("#{model_configuration.model_name}_attributes", attributes_for).to_s
  end

  def nested_attributes_lets
    model_configuration.associations.select(&:is_nested?).map do |association|
      key            = "#{association.name}_attributes"
      attributes_for = Frontier::FactoryGirlSupport::AttributesFor.new(association).to_s

      Frontier::SpecSupport::LetStatement.new(key, attributes_for).to_s
    end
  end

end

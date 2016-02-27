class Frontier::SpecSupport::ObjectSetup::AssociatedModelSetup

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  # Provide the let declarations that will setup the associated models to be used in the params:
  #
  #   # In spec setup:
  #   let(:address) { FactoryGirl.create(:address) }
  #
  #   # In params
  #   let(:params) { {address_id: address.id} }
  #
  def to_s
    model_configuration.associations.map do |association|
      # Nested forms can have their own associations
      if association.is_nested?
        Frontier::SpecSupport::ObjectSetup::AssociatedModelSetup.new(association).to_s
      else
        factory_statement = Frontier::FactoryGirlSupport::Declaration.new("create", association).to_s
        Frontier::SpecSupport::LetStatement.new(association.name, factory_statement).to_s
      end
    end.join("\n")
  end

end

class Frontier::SpecSupport::ControllerParams::AssociatedModelSetup

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
    model_configuration.associations.select {|a| !a.is_nested?}.map do |association|
      factory_statement = Frontier::FactoryGirlSupport::Declaration.new("create", association).to_s
      Frontier::SpecSupport::LetStatement.new(association.name, factory_statement).to_s
    end.join("\n")
  end

end

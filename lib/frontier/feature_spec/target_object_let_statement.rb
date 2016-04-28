class Frontier::FeatureSpec::TargetObjectLetStatement

  include Frontier::ModelConfigurationProperty

  # Sets up the object that we are using in our spec and any other objects that are required
  # to use this object (like nested objects).
  #
  # Example: Normal object
  #
  # let!(:claim) { FactoryGirl.create(:claim) }
  #
  # Example: Nested object
  #
  # let!(:claim) { FactoryGirl.create(:claim, client: client) }
  # let(:client) { FactoryGirl.create(:client) }
  #
  # * The parent object (client) will be used in route generation in other parts of the feature spec.
  #
  # Example: With include_resource false (In some specs, we are only interested in having the children objects)
  #
  # let(:client) { FactoryGirl.create(:client) }
  #
  def to_s(include_resource: true)
    [
      (let_statement_for_resource(model_configuration.model_name, model_configuration.controller_prefixes) if include_resource),
      *let_statements_for_nested_resources
    ].select(&:present?).join("\n")
  end

private

  def let_statements_for_nested_resources
    nested_models = model_configuration.controller_prefixes.select(&:nested_model?)

    # We reverse here because we want the statements to be ordered by how close they are
    # to the resource.
    #
    # Example: controller_prefixes: [@company, @client]
    #
    # let!(:claim) { FactoryGirl.create(:claim, client: client) }
    # let(:client) { FactoryGirl.create(:client, company: company) }
    # let(:company) { FactoryGirl.create(:company) }
    #
    nested_models.reverse.map do |controller_prefix|
      # In the above example, the preceding_controller_prefixes will be [@company] for @client
      # and [] for @company
      preceding_controller_prefixes = nested_models.first(nested_models.index(controller_prefix))
      let_statement_for_resource(controller_prefix.as_snake_case, preceding_controller_prefixes, has_bang: false)
    end
  end

  def factory_arguments_for(controller_prefixes)
    if controller_prefixes.any?
      {controller_prefixes.last.as_snake_case => controller_prefixes.last.as_snake_case}
    else
      {}
    end
  end

  def let_statement_for_resource(resouce_name, controller_prefixes, has_bang: true)
    let_statement = Frontier::SpecSupport::LetStatement.new(resouce_name, factory_girl_call(resouce_name, controller_prefixes))
    let_statement.to_s(has_bang: has_bang)
  end

  def factory_girl_call(resouce_name, controller_prefixes)
    factory = Frontier::FactoryGirlSupport::Declaration.new("create", resouce_name)
    factory.to_s(factory_arguments_for(controller_prefixes))
  end

end

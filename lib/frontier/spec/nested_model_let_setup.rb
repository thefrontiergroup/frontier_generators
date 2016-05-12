class Frontier::Spec::NestedModelLetSetup

  include Frontier::ModelConfigurationProperty

  # When a Frontier::ModelConfiguration has one or more nested models we can generate let
  # statements for them. EG:
  #
  # # One nested
  # let(:company) { FactoryGirl.create(:company) }
  #
  # # Two nested
  # let(:site) { FactoryGirl.create(:site, company: company) }
  # let(:company) { FactoryGirl.create(:company) }
  #
  def to_s
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
      let_statement_for_resource(controller_prefix.as_snake_case, preceding_controller_prefixes)
    end.join("\n")
  end

private

  def factory_arguments_for(controller_prefixes)
    nested_models = controller_prefixes.select(&:nested_model?)
    if nested_models.any?
      {nested_models.last.as_snake_case => nested_models.last.as_snake_case}
    else
      {}
    end
  end

  def factory_girl_call(resouce_name, controller_prefixes)
    factory = Frontier::FactoryGirlSupport::Declaration.new("create", resouce_name)
    factory.to_s(factory_arguments_for(controller_prefixes))
  end

  def let_statement_for_resource(resouce_name, controller_prefixes)
    let_statement = Frontier::Spec::LetStatement.new(resouce_name, factory_girl_call(resouce_name, controller_prefixes))
    let_statement.to_s(has_bang: false)
  end

end

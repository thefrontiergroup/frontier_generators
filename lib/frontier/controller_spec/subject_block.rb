class Frontier::ControllerSpec::SubjectBlock

  attr_reader :model_configuration, :method, :action, :params

  def initialize(model_configuration, method, action, params={})
    @model_configuration = model_configuration
    @method = method
    @action = action
    @params = params
  end

  def to_s
    [
      "subject { #{subject_contents} }",
      nested_model_setup
    ].reject(&:blank?).join("\n")
  end

private

  def nested_model_prefixes
    model_configuration.controller_prefixes.select(&:nested_model?).sort_by(&:as_snake_case)
  end

  def nested_model_params
    nested_params = {}
    nested_model_prefixes.each do |controller_prefix|
      nested_params["#{controller_prefix.as_snake_case}_id"] = "#{controller_prefix.as_snake_case}.id"
    end
    nested_params
  end

  # For a model that is nested, we need to ensure that the objects that
  # the model is nested under are provided. EG:
  #
  #   subject { get :index, user_id: user.id }
  #   let(:user) { FactoryGirl.create(:user) }
  #
  def nested_model_setup
    nested_model_prefixes.map do |controller_prefix|
      factory_statement = Frontier::FactoryGirlSupport::Declaration.new("create", controller_prefix.as_snake_case).to_s
      Frontier::SpecSupport::LetStatement.new(controller_prefix.as_snake_case, factory_statement)
    end.join("\n")
  end

  def subject_contents
    [
      "#{method} :#{action}",
      Frontier::HashSingleLineDecorator.new(nested_model_params.merge(params)).to_s,
    ].reject(&:empty?).join(", ")
  end

end

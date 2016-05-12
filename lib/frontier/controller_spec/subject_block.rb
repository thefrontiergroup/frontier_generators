class Frontier::ControllerSpec::SubjectBlock

  attr_reader :model_configuration, :method, :action, :params

  def initialize(model_configuration, method, action, params={})
    @model_configuration = model_configuration
    @method = method
    @action = action
    @params = params
  end

  def to_s
    "subject { #{subject_contents} }"
  end

private

  def nested_model_prefixes
    model_configuration.controller_prefixes
                       .select(&:nested_model?)
                       .sort_by(&:as_snake_case)
  end

  def nested_model_params
    nested_params = {}
    nested_model_prefixes.each do |controller_prefix|
      nested_params["#{controller_prefix.as_snake_case}_id"] = "#{controller_prefix.as_snake_case}.id"
    end
    nested_params
  end

  def subject_contents
    [
      "#{method} :#{action}",
      Frontier::HashSingleLineDecorator.new(nested_model_params.merge(params)).to_s,
    ].reject(&:empty?).join(", ")
  end

end

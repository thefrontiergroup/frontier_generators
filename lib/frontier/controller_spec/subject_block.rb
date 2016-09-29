class Frontier::ControllerSpec::SubjectBlock

  attr_reader :model, :method, :action, :params

  def initialize(model, method, action, params={})
    @model = model
    @method = method
    @action = action
    @params = params
  end

  def to_s
    "subject { #{subject_contents} }"
  end

private

  def nested_model_prefixes
    model.controller_prefixes
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

class Frontier::FeatureSpec::VisitIndexMethod

  include Frontier::ModelConfigurationProperty

  def method_name
    "visit_index"
  end

  def to_s
    raw = <<-STRING
def #{method_name}
  visit(#{index_path})
end
STRING
    raw.rstrip
  end

private

  def index_path
    model_configuration.url_builder.index_path(show_nested_model_as_ivar: false)
  end

end

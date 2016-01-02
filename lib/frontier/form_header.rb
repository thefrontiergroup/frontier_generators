class Frontier::FormHeader

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_s
    "simple_form_for #{form_name}, #{Frontier::HashDecorator.new(form_options)} do |f|"
  end

private

  def form_name
    if model_configuration.namespaces.any?
      # [:namespace, @instance]
      namespaces = model_configuration.namespaces.map{|ns| ":#{ns}"}.join(", ")
      "[#{namespaces}, #{model_configuration.as_ivar_instance}]"
    else
      model_configuration.as_ivar_instance
    end
  end

  def form_options
    {
      wrapper: "horizontal",
      html: {
        class: "form-horizontal"
      }
    }
  end

end

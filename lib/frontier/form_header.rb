class Frontier::FormHeader

  include Frontier::ModelConfigurationProperty

  def to_s
    "simple_form_for #{form_name}, #{Frontier::HashSingleLineDecorator.new(form_options)} do |f|"
  end

private

  def form_name
    # [:namespace, @instance], or
    # [@nested_model, @instance]
    if model_configuration.controller_prefixes.any?
      form_components = model_configuration.controller_prefixes.map(&:as_form_component)
      "[#{form_components.join(", ")}, #{model_configuration.as_ivar_instance}]"
    # @instance
    else
      model_configuration.as_ivar_instance
    end
  end

  def form_options
    {
      wrapper: '"horizontal"',
      html: {
        class: '"form-horizontal"'
      }
    }
  end

end

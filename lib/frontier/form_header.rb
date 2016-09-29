class Frontier::FormHeader

  include Frontier::ModelProperty

  def to_s
    "simple_form_for #{form_name}, #{Frontier::HashSingleLineDecorator.new(form_options)} do |f|"
  end

private

  def form_name
    # [:namespace, @instance], or
    # [@nested_model, @instance]
    if model.controller_prefixes.any?
      form_components = model.controller_prefixes.map(&:as_form_component)
      "[#{form_components.join(", ")}, #{model.as_ivar_instance}]"
    # @instance
    else
      model.as_ivar_instance
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

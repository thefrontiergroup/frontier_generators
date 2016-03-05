class Frontier::Input::InlineFormAssociation < Frontier::Input::Association

  # Will generate an inline form, something like:
  #
  # f.simple_fields_for :association_name do |ff|
  #   ff.input :name
  #
  # The Frontier::HamlRenderer class can append = to these statements, so that it the output
  # will look like:
  #
  # = f.simple_fields_for :association_name do |ff|
  #   = ff.input :name
  def to_s(options={})
    preamble = <<-CODE
f.simple_fields_for #{association.as_symbol} do |ff|
  %fieldset
    %legend #{association.name.titleize}
CODE
    preamble + Frontier::RubyRenderer.new(generate_inputs(options)).render(2).rstrip
  end

private

  def input_for_attribute(attribute)
    Frontier::Input::Factory.build_for(attribute).to_s(form_name: "ff")
  end

  def generate_inputs(options)
    # Only provide the whitespace indenting if there are some attributes. If there aren't,
    # don't inject any whitespace
    if association.attributes.length > 0
      association.attributes.map {|attribute| input_for_attribute(attribute)}.join("\n")
    else
      ""
    end
  end

end

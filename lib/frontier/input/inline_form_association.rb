class Frontier::Input::InlineFormAssociation < Frontier::Input::Association

  def to_s(options={})
    # options = options.merge({collection: "#{association.association_class}.all"})
    # # Should convert attribute "state" into:
    # #   f.association :state, collection: State.all
    # # With additional options as above you'd get:
    # #   f.association :state, abacus: 666, collection: State.all, one: :two
    # ["f.association #{attribute.as_symbol_without_id}", *input_options(options)].join(", ")
    <<-CODE
f.simple_fields_for(#{association.as_symbol_without_id}) do |ff|
#{generate_inputs(options)}
end
CODE
  end

private

  def generate_inputs(options)
    # Only provide the whitespace indenting if there are some attributes. If there aren't,
    # don't inject any whitespace
    if association.attributes.length > 0
      [
        "  ",
        association.attributes.map {|attribute| Frontier::Input::Factory.build_for(attribute).to_s(form_name: "ff")}.join("\n  ")
      ].join
    end
  end

end
